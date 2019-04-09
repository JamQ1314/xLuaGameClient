NiuNiuCtrl = {}
local this = NiuNiuCtrl
this.RoomID = 0
this.SeatID = 0
this.NNPlayers = {}

function this.Init()
	if not NiuNiuView then
		require "ui.NiuNiuView"
	end
	CS.GApp.UIMgr:Open("prefabs.ui.NiuNiuView",this.OnCreate);
end

function this.OnCreate()
	CS.UIEventListener.Get(NiuNiuView.transform:Find("upright/exitbtn")).onClick = this.close
	
end

function this.close(go)
	local sInt = simplepb.SimpleInt()
	sInt.simple = this.RoomID
	data = sInt:SerializeToString()
	CS.GApp.NetMgr:Send(0,Main_ID.NiuNiu,NiuNiu_ID.Leave,data)
end

function this.PlayerJion(newPlayer)
	this.NNPlayers[#this.NNPlayers + 1] =  newPlayer
	NiuNiuView.
end