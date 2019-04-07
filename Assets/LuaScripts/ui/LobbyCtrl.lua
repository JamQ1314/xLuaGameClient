LobbyCtrl = {}
local this = LobbyCtrl

function this.Init()
	require "ui.LobbyView"
	CS.GApp.UIMgr:Open("prefabs.ui.LobbyView",this.OnCreate);
	
end

function this.OnCreate()
	local roompanel = LobbyView.transform:Find("bg/room")
	roompanel:Find("lobbycreateroombtn"):GetComponent("UnityEngine.UI.Button").onClick:AddListener(this.CreateRoom)
	roompanel:Find("lobbyjionroombtn"):GetComponent("UnityEngine.UI.Button").onClick:AddListener(this.JionRoom)
	
	local upbtnpanel = LobbyView.transform:Find("bg/upbutton")
	local bottombtnpanel = LobbyView.transform:Find("bg/bottombutton")
end

function this.JionRoom()
	CS.GApp.NetMgr:Send(0,Main_ID.NiuNiu,NiuNiu_ID.Jion,nil)
end

function this.CreateRoom()
	print("CreateRoom")
	CS.GApp.NetMgr:Send(0,Main_ID.NiuNiu,NiuNiu_ID.Create,nil)
end