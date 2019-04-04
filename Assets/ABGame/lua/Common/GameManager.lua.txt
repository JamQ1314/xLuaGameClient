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
	local userinfo = userpb.User()
	userinfo.name = "你好！"
	userinfo.id = 99
	userinfo.gold = 1000
	userinfo.sex = 0
	GameCache.userinfo = userinfo
	
	require "ui.LobbyCtrl"
	LobbyCtrl.Init()
end