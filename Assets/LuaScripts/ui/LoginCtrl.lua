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
	CS.GApp.UIMgr:GetGameObject("wxloginbtn"):GetComponent("UnityEngine.UI.Button").onClick:AddListener(LoginCtrl.wxlogin)
	
	--if CS.GApp.Ins:GetMode() == 0 then
	--LoginView:AccLoginPanel()
	--CS.GApp.UIMgr:GetGameObject("accloginbtn"):GetComponent("UnityEngine.UI.Button").onClick:AddListener(LoginCtrl.accLogin)
	--CS.GApp.UIMgr:GetGameObject("accregisterbtn"):GetComponent("UnityEngine.UI.Button").onClick:AddListener(LoginCtrl.accRegister)
	--end
	--连接服务器
	LoginCtrl.netConn()
end

function LoginCtrl.wxlogin()
	--暂时使用游客登陆
	vid = CS.PlayerPrefsSaveValue.GetInt("visitorid")
	CS.GApp.NetMgr:SendInt(0,Main_ID.Lobby,Lobby_ID.VisitorLogin,vid)
end


function LoginCtrl.netConn()
	CS.GApp.NetMgr:Connect(0,"127.0.0.1",5555)
end