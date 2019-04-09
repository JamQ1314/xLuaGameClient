NiuNiuView = {}
local this = NiuNiuView


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
	
	this.transform:Find("roominfo/roomid"):GetComponent("UnityEngine.UI.Text").text = "房号:"..NiuNiuCtrl.RoomID
	--显示自身信息 隐藏其他角色
	local userinfo = GameCache.userinfo
	local userspanel = this.transform:Find("players")
	for i = 0, 5 do
		local playerpanel = userspanel:Find("player"..i)
		playerpanel:Find("pokes").gameObject:SetActive(false)
		if i==0 then
			playerpanel:Find("nametx"):GetComponent("UnityEngine.UI.Text").text = userinfo.name
			playerpanel:Find("goldtx"):GetComponent("UnityEngine.UI.Text").text = math.ceil(userinfo.gold)
		else
			playerpanel.gameObject:SetActive(false)
		end
	end
	--隐藏 翻牌按钮
	this.transform:Find("showpokesbtn").gameObject:SetActive(false)
end


function this.close()
	
end
