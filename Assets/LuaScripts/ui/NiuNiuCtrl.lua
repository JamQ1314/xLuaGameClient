NiuNiuCtrl = {}
local this = NiuNiuCtrl
this.RoomID = 123
this.SeatID = nil
this.NNPlayers = nil

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