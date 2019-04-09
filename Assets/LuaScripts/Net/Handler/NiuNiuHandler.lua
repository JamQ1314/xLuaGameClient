NiuNiuHandler = {}
local this = NiuNiuHandler

function this.Init()
	CS.GApp.NetMgr:RegisterHandler(Main_ID.NiuNiu,this.HandleMsg)
	
	if not NiuNiuCtrl then
		require "ui.NiuNiuCtrl"
	end
end

function this.HandleMsg(sid,bytes)
	if sid == NiuNiu_ID.CreateSuccess then
		this.DoCreateSuccess(bytes)
	elseif sid == NiuNiu_ID.JionSuccess then
		this.DoJionSuccess(bytes)
	elseif sid == NiuNiu_ID.JionFailure then
		this.DoJionFailure(bytes)
	elseif sid == NiuNiu_ID.PlayerJion then
		this.DoPlayerJion(bytes)
	elseif sid == NiuNiu_ID.LeaveSuccess then
		this.DoLeaveSuccess(bytes)
	end
	
	
end

function this.DoCreateSuccess(bytes)
	local simpleint = simplepb.SimpleInt()
	simpleint:ParseFromString(bytes)
	NiuNiuCtrl.RoomID = math.ceil(simpleint.simple)
	
	NiuNiuCtrl.SeatID = 0
	
	local slefPlayer = userpb.GamePlayer()
	slefPlayer.seatid = 0
	local userinfo = GameCache.userinfo
	slefPlayer.user.id = userinfo.id
	slefPlayer.user.name = userinfo.name
	slefPlayer.user.gold = userinfo.gold
	slefPlayer.user.sex = userinfo.sex
	NiuNiuCtrl.NNPlayers[0] = slefPlayer
	
	NiuNiuCtrl.Init()
end

function this.DoJionSuccess(bytes)
	local seatPlayers = userpb.GameSeatedUPlayers()
	seatPlayers:ParseFromString(bytes)
	
	local nnPlayers = seatPlayers.players
	NiuNiuCtrl.NNPlayers = nnPlayers
	
	for i = 1, #nnPlayers do
		local pinfo = nnPlayers[i]
		if pinfo.user.id == GameCache.userinfo.id then
			NiuNiuCtrl.SeatID = pinfo.seatid
			break
		end
	end
	NiuNiuCtrl.RoomID = tonumber(JionRoomCtrl.GetRoomID())
	NiuNiuCtrl.Init()
end

function this.DoJionFailure(bytes)
	local msg = simplepb.SimpleString()
	msg:ParseFromString(bytes)
	JionRoomCtrl.JionRoomFailuer(msg.simple)
end

function this.DoPlayerJion(bytes)
	local newPlayer = userpb.GamePlayer()
	newPlayer:ParseFromString(bytes)
	JionRoomCtrl.PlayerJion(newPlayer)
end
function this.DoLeaveSuccess(bytes)
	local user = userpb.User()
	user:ParseFromString(bytes)
	--保存数据
	GameCache.userinfo = user
	print("返回大厅 :" ..user.id .."   "..user	.name)
	CS.GApp.UIMgr:CloseAll()
	--返回大厅
	LobbyCtrl.Init()
end