LobbyView = {}
local this = LobbyView


function this.awake(go)
	print("LobbyView.awake : "..go.name)
	this.transform = go.transform
	this.gameobject = go;
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
	local userpanel = this.transform:Find("bg/user")
	userpanel:Find("username"):GetComponent("UnityEngine.UI.Text").text = userinfo.name
	userpanel:Find("id"):GetComponent("UnityEngine.UI.Text").text = userinfo.id
	userpanel:Find("gold/Text"):GetComponent("UnityEngine.UI.Text").text = userinfo.gold
end

function this.close()
	
end

function this.Test()
	print(transform.name)
end