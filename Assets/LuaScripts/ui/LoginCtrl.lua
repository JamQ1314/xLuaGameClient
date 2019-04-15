LoginCtrl = {}
local this = LoginCtrl


function LoginCtrl.Init()
	--初始化
	require "ui.LoginView"
	CS.GApp.UIMgr:Open("prefabs.ui.LoginView",LoginCtrl.OnCreate);
	
	require "Net.Handler.LobbyHandler"
	LobbyHandler.Init()
end	


function LoginCtrl.OnCreate()
	--创建UI后回调
	--CS.GApp.UIMgr:GetGameObject("wxloginbtn"):GetComponent("UnityEngine.UI.Button").onClick:AddListener(LoginCtrl.wxlogin)
	CS.UIEventListener.Get(LoginView.transform:Find("bg/wxloginbtn")).onClick = LoginCtrl.wxlogin
	--连接服务器
	LoginCtrl.netConn()
end

function LoginCtrl.wxlogin(go)
	--暂时使用游客登陆
	vid = CS.PlayerPrefsSaveValue.GetInt("visitorid")
	local simpleint = simplepb.SimpleInt()
	simpleint.simple = vid
	local bytes = simpleint:SerializeToString()
	CS.GApp.NetMgr:Send(0,Main_ID.Lobby,Lobby_ID.VisitorLogin,bytes)
end


function LoginCtrl.netConn()
	CS.GApp.NetMgr:Connect(0,"111.230.129.194",5555)
end