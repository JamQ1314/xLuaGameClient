LobbyCtrl = {}
local this = LobbyCtrl

function this.Init()
	require "ui.LobbyView"
	CS.GApp.UIMgr:Open("prefabs.ui.LobbyView",this.OnCreate);
	CS.GApp.UIMgr:GetGameObject("jionroom"):GetComponent(typeof(CS.UIBehaviour)):AddClickListener(this.JionRoom)
	
end

function this.OnCreate()
	
end

function this.JionRoom()
	CS.GApp.UIMgr:Open("prefabs.ui.JionRoomView");
end