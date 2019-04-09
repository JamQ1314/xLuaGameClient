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
	NiuNiuCtrl.Init()
end

function this.DoJionSuccess(bytes)
	local seatPlayers = userpb.GameSeatedUPlayers()
	seatPlayers:ParseFromString(bytes)
	
	NiuNiuCtrl.NNPlayers = seatPlayers.players
	
	NiuNiuCtrl.RoomID = tonumber(JionRoomCtrl.GetRoomID())
	print("DoJionSuccess : " ..tonumber(JionRoomCtrl.RoomID))
	print("DoJionSuccess : " ..NiuNiuCtrl.RoomID )
	NiuNiuCtrl.Init()
end

function this.DoJionFailure(bytes)
	local msg = simplepb.SimpleString()
	msg:ParseFromString(bytes)
	JionRoomCtrl.JionRoomFailuer(msg.simple)
end

function this.DoPlayerJion(bytes)
	
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