LobbyView = {}
local this = LobbyView


function this.awake(go)
	this.transform = go.transform
	this.gameobject = go;
end

function  this.start()
	
	
end

function  this.update()
	
end

function  this.ondestroy()
	
end

function this.open()
	local userinfo = GameCache.userinfo
	local userpanel = this.transform:Find("bg/user")
	userpanel:Find("username"):GetComponent("UnityEngine.UI.Text").text = userinfo.name
	userpanel:Find("id"):GetComponent("UnityEngine.UI.Text").text = "ID:"..math.ceil(userinfo.id) 
	userpanel:Find("gold/Text"):GetComponent("UnityEngine.UI.Text").text = math.ceil(userinfo.gold)
	--
	
end

function this.close()
	
end

function this.Test()
	print(transform.name)
end