GameManager = {}
local this = GameManager


function this.Start()
	require "Common.GamePBLoader"
	require "Common.GameCache"
	require "Net.Common.NetDefines"

	
	--this.OpenLobby()
	this.OpenLogin()

end

function this.OpenLogin()
	--加载登陆
	require "ui.LoginCtrl"
	LoginCtrl.Init()
end

function this.OpenLobby()
	
	CS.GApp.NetMgr:Connect(Socket_ID.Common,GApp.server_addr,GApp.server_port)
	
	local userinfo = userpb.User()
	userinfo.name = "你好！"
	userinfo.id = 99
	userinfo.gold = 9999
	userinfo.sex = 0
	GameCache.userinfo = userinfo
	
	require "ui.LobbyCtrl"
	LobbyCtrl.Init()
end