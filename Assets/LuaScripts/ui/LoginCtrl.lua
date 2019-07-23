LoginCtrl = {}
local this = LoginCtrl
this.TexBytes = nil

function LoginCtrl.Init()
	--打开登录界面
	require "ui.LoginView"
	CS.GApp.UIMgr:Open("prefabs.ui.loginview",LoginCtrl.OnCreate);
	
end	


function LoginCtrl.OnCreate()
	--创建UI后回调
	--CS.GApp.UIMgr:GetGameObject("wxloginbtn"):GetComponent("UnityEngine.UI.Button").onClick:AddListener(LoginCtrl.wxlogin)
	CS.UIEventListener.Get(LoginView.GetGo("bg/accLogin/btn_login_close")).onClick = this.exit
	CS.UIEventListener.Get(LoginView.GetGo("bg/accLogin/btn_acclogin")).onClick = this.accloogin
	CS.UIEventListener.Get(LoginView.GetGo("bg/accLogin/btn_accregister")).onClick = this.openregister
	
	CS.UIEventListener.Get(LoginView.GetGo("bg/accRegister/btn_reg_close")).onClick = this.openlogin
	CS.UIEventListener.Get(LoginView.GetGo("bg/accRegister/btn_accapply")).onClick = this.accregister
	CS.UIEventListener.Get(LoginView.GetGo("bg/accRegister/headIco/btn_edithead")).onClick = this.EditHead
	--连接服务器
	LoginCtrl.netConn()
	
	require "Net.Handler.LobbyHandler"
	LobbyHandler.Init()
end

function this.exit(go)
	print("exit game")
	CS.UnityEngine.Application.Quit(go)
end

function this.acclogin(go)
	print("login")
end

function this.openregister(go)
	LoginView.setmode(1)
end
function this.openlogin(go)
	LoginView.setmode(1)
end
function this.accregister(go)
	print("register")
	local acc ,pwd = LoginView.GetRegisterInfo()
	if acc==nil or pwd==nil then
		return
	end
	local data = accpb.Account()
	data.nickname = ""
	data.roomid = -1
	data.acc = acc
	data.pwd = pwd
	data.id = -1
	data.ico = this.TexBytes
	local bytes = data:SerializeToString()
	CS.GApp.NetMgr:Send(Socket_ID.Common,Main_ID.Lobby,Lobby_ID.AccRegister,bytes)
end

function this.EditHead(go)
	print("edithead")
	CS.MainHelper.EditHead(function (bytes)
			this.TexBytes = bytes;
	end)
end



function LoginCtrl.wxlogin(go)
	if true then
		return
	end
	--暂时使用游客登陆
	--vid = CS.PlayerPrefsSaveValue.GetInt("visitorid")
	--local simpleint = simplepb.SimpleInt()
	--simpleint.simple = vid
	--local bytes = simpleint:SerializeToString()
	--CS.GApp.NetMgr:Send(0,Main_ID.Lobby,Lobby_ID.VisitorLogin,bytes)
end




function LoginCtrl.netConn()
	CS.GApp.NetMgr:Connect(Socket_ID.Common,GApp.server_addr,GApp.server_port)
end


