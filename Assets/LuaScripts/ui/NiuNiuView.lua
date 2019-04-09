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
	
	this.DisPlayers()
end

function this.DisPlayers()
	--显示其他角色
	local nnPlayers = NiuNiuCtrl.NNPlayers
	local selfSeatID = NiuNiuCtrl.SeatID
	if #nnPlayers > 1 then
		for i = 1, #nnPlayers do
			local pinfo = nnPlayers[i]
			if pinfo.seatid ~= selfSeatID then
				local xseatid = pinfo.seatid - selfSeatID
				if xseatid < 0 then
					xseatid = xseatid+6
				end
				local userspanel = this.transform:Find("players")
				local playerpanel = userspanel:Find("player"..math.ceil(xseatid))
				playerpanel.gameObject:SetActive(true)
				playerpanel:Find("nametx"):GetComponent("UnityEngine.UI.Text").text = pinfo.user.name
				playerpanel:Find("goldtx"):GetComponent("UnityEngine.UI.Text").text = math.ceil(pinfo.user.gold)
			end
		end
	end
end

function this.PlayerJion(pinfo)
	if pinfo.seatid ~= selfSeatID then
		local xseatid = pinfo.seatid - selfSeatID
		if xseatid < 0 then
			xseatid = xseatid+6
		end
		local userspanel = this.transform:Find("players")
		local playerpanel = userspanel:Find("player"..math.ceil(xseatid))
		playerpanel.gameObject:SetActive(true)
		playerpanel:Find("nametx"):GetComponent("UnityEngine.UI.Text").text = pinfo.user.name
		playerpanel:Find("goldtx"):GetComponent("UnityEngine.UI.Text").text = math.ceil(pinfo.user.gold)
	end
end

function this.close()
	
end
