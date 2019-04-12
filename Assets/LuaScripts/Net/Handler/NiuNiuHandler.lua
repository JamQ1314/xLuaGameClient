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
	elseif sid == NiuNiu_ID.ReadySuccess then
		this.DoReadySuccess(bytes)
	elseif sid == NiuNiu_ID.TurnHost then
		this.DoTurnHost(bytes)
	elseif sid == NiuNiu_ID.GameDeal then
		this.DoGameDeal(bytes)
	end
	
	
end

function this.DoCreateSuccess(bytes)
	local simpleint = simplepb.SimpleInt()
	simpleint:ParseFromString(bytes)
	NiuNiuCtrl.DataInit()
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
	
	NiuNiuCtrl.DataInit()
	NiuNiuCtrl.RoomID = math.ceil(seatPlayers.roomid)
	NiuNiuCtrl.HostID = math.ceil(seatPlayers.hostid)
	
	local nnPlayers = seatPlayers.players
	NiuNiuCtrl.NNPlayers = nnPlayers
	
	for i = 1, #nnPlayers do
		local pinfo = nnPlayers[i]
		if pinfo.user.id == GameCache.userinfo.id then
			NiuNiuCtrl.SeatID = pinfo.seatid
			break
		end
	end
	NiuNiuCtrl.Init()
end

function this.DoJionFailure(bytes)
	local msg = simplepb.SimpleString()
	msg:ParseFromString(bytes)
	JionRoomCtrl.JionRoomFailuer(msg.simple)
end
--玩家加入游戏
function this.DoPlayerJion(bytes)
	local newPlayer = userpb.GamePlayer()
	newPlayer:ParseFromString(bytes)
	NiuNiuCtrl.PlayerJion(newPlayer)
end
--离开游戏
function this.DoLeaveSuccess(bytes)
	local msg = simplepb.SimpleInt()
	msg:ParseFromString(bytes)
	NiuNiuCtrl.PlayerLeave(math.ceil(msg.simple))
end
--玩家准备
function this.DoReadySuccess(bytes)
	local msg = simplepb.SimpleInt()
	msg:ParseFromString(bytes)
	NiuNiuCtrl.PlayerReady(math.ceil(msg.simple))
end
--切换庄家
function this.DoTurnHost(bytes)
	local msg = simplepb.SimpleInt()
	msg:ParseFromString(bytes)
	NiuNiuCtrl.TurnHost(math.ceil(msg.simple))
end

function this.DoGameDeal(bytes)
	local msg = cardpb.OnePlayerCards()
	msg:ParseFromString(bytes)
	
	str = "收到卡牌"..msg.cards[1].."  "..msg.cards[2].."  "..msg.cards[3].."  "..msg.cards[4].."  "..msg.cards[5]
	print(str)
	
	NiuNiuCtrl.GameDeal(msg.cards)
end