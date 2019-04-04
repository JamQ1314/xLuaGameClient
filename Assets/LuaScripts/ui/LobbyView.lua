LobbyView = {}
local this = LobbyView

local transform
local gameobject


function this.awake(go)
	print("LobbyView.awake : "..go.name)
	transform = go.transform
	gameobject = go;
end

function  this.start()
	print("LoginView:start")
	
end

function  this.update()
	
end

function  this.ondestroy()
	
end

function this.open()
	local userinfo = GameCache.userinfo
	local userpanel = transform:Find("bg/user")
	userpanel:Find("username"):GetComponent("UnityEngine.UI.Text").text = userinfo.name
	userpanel:Find("id"):GetComponent("UnityEngine.UI.Text").text = userinfo.id
	userpanel:Find("gold/Text"):GetComponent("UnityEngine.UI.Text").text = userinfo.gold
end

function this.close()
	
end