NiuNiuCtrl = {}
local this = NiuNiuCtrl
this.RoomID = 0
this.SeatID = 0
this.HostID = 0 --庄家ID
this.NNPlayers = {}
this.UserInfo = GameCache.userinfo

function this.DataInit()
	this.RoomID = 0
	this.SeatID = 0
	this.HostID = 0 --庄家ID
	this.NNPlayers = {}
	this.UserInfo = GameCache.userinfo
end
function this.Init()
	if not NiuNiuView then
		require "ui.NiuNiuView"
	end
	CS.GApp.UIMgr:Open("prefabs.ui.NiuNiuView",this.OnCreate);
end

function this.OnCreate()
	CS.UIEventListener.Get(NiuNiuView.transform:Find("upright/exitbtn")).onClick = this.close
	CS.UIEventListener.Get(NiuNiuView.transform:Find("readybtn")).onClick = this.ready
	
end

function this.close(go)
	local sInt = simplepb.SimpleInt()
	sInt.simple = this.RoomID
	data = sInt:SerializeToString()
	CS.GApp.NetMgr:Send(0,Main_ID.NiuNiu,NiuNiu_ID.Leave,data)
end

function this.ready()
	local sInt = simplepb.SimpleInt()
	sInt.simple = this.RoomID
	data = sInt:SerializeToString()
	
	CS.GApp.NetMgr:Send(0,Main_ID.NiuNiu,NiuNiu_ID.Ready,data)
end

function this.PlayerJion(newPlayer)
	NiuNiuView.PlayerJion(newPlayer)
end

function this.PlayerLeave(pseatid)
	if pseatid == this.SeatID then
		--自己的话缓存数据，返回大厅
		GameCache.userinfo = this.UserInfo
		
		CS.GApp.UIMgr:CloseAll()
		--返回大厅
		LobbyCtrl.Init()
	else
		NiuNiuView.PlayerLeave(pseatid)
	end
end

function this.PlayerReady(pseatid)
	NiuNiuView.PlayerReady(pseatid)
end

function this.TurnHost(pseatid)
	NiuNiuView.DisHostIco(pseatid)
end

function this.GameDeal(cards)
	NiuNiuView.GameDeal(cards)
end