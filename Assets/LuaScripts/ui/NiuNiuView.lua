NiuNiuView = {}
local this = NiuNiuView
local AllPlayerPanels = {} 

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
	AllPlayerPanels = {}
	
	this.transform:Find("roominfo/roomid"):GetComponent("UnityEngine.UI.Text").text = "房号:"..NiuNiuCtrl.RoomID
	--显示自身信息 隐藏其他角色
	local userinfo = GameCache.userinfo
	local userspanel = this.transform:Find("players")
	--获取为准备头像框
	local noReadySprite = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex("moren")
	for i = 0, 5 do
		local playerpanel = userspanel:Find("player"..i)
		playerpanel:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = noReadySprite
		playerpanel:Find("pokes").gameObject:SetActive(false)
		if i==0 then
			AllPlayerPanels[0] = playerpanel
			playerpanel:Find("nametx"):GetComponent("UnityEngine.UI.Text").text = userinfo.name
			playerpanel:Find("goldtx"):GetComponent("UnityEngine.UI.Text").text = math.ceil(userinfo.gold)
		else
			playerpanel.gameObject:SetActive(false)
		end
	end
	--隐藏 翻牌按钮
	this.transform:Find("showpokesbtn").gameObject:SetActive(false)
	this.transform:Find("readybtn").gameObject:SetActive(true)
	
	this.DisPlayers()
	this.DisHostIco(NiuNiuCtrl.HostID)
end

function this.DisPlayers()
	--显示其他角色
	local nnPlayers = NiuNiuCtrl.NNPlayers
	local selfSeatID = NiuNiuCtrl.SeatID
	if #nnPlayers > 1 then
		for i = 1, #nnPlayers do
			local pinfo = nnPlayers[i]
			if pinfo.seatid ~= selfSeatID then -- 不是自己则显示
				local xseatid = pinfo.seatid - selfSeatID
				if xseatid < 0 then
					xseatid = xseatid+6
				end
				local userspanel = this.transform:Find("players")
				local playerpanel = userspanel:Find("player"..math.ceil(xseatid))
				if pinfo.state ==1 then --玩家状态为准备
					local ReadySprite = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex("dangqian")
					playerpanel:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = ReadySprite
				end
				
				AllPlayerPanels[xseatid] = playerpanel
				playerpanel.gameObject:SetActive(true)
				playerpanel:Find("nametx"):GetComponent("UnityEngine.UI.Text").text = pinfo.user.name
				playerpanel:Find("goldtx"):GetComponent("UnityEngine.UI.Text").text = math.ceil(pinfo.user.gold)
			end
		end
	end
end
--单个玩家加入
function this.PlayerJion(pinfo)
	local selfSeatID = NiuNiuCtrl.SeatID
	if pinfo.seatid ~= selfSeatID then
		local xseatid = pinfo.seatid - selfSeatID
		if xseatid < 0 then
			xseatid = xseatid+6
		end
		local userspanel = this.transform:Find("players")
		local playerpanel = userspanel:Find("player"..math.ceil(xseatid))
		AllPlayerPanels[xseatid] = playerpanel
		local noReadySprite = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex("moren")
		playerpanel:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = noReadySprite
		playerpanel.gameObject:SetActive(true)
		playerpanel:Find("nametx"):GetComponent("UnityEngine.UI.Text").text = pinfo.user.name
		playerpanel:Find("goldtx"):GetComponent("UnityEngine.UI.Text").text = math.ceil(pinfo.user.gold)
	end
end

function this.PlayerLeave(pSeatID)
	local xseatid = this.GetXSeatID(pSeatID)
	local playerpanel = this.GetPlayerPanelByXSeatID(xseatid)
	playerpanel.gameObject:SetActive(false)
	AllPlayerPanels[xseatid] = nil
end

function this.PlayerReady(pSeatID)
	local xseatid = this.GetXSeatID(pSeatID)
	local playerpanel = this.GetPlayerPanelByXSeatID(xseatid)
	--更改头像框 高亮为准备状态
	local ReadySprite = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex("dangqian")
	playerpanel:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = ReadySprite
	
	if xseatid == 0 then
		--隐藏准备按钮
		this.transform:Find("readybtn").gameObject:SetActive(false)
	end
end

function this.GameDeal(cards)
	for k, v in pairs(AllPlayerPanels) do
		local playerpanel = v
		local noReadySprite = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex("moren")
		playerpanel:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = noReadySprite
		playerpanel:Find("pokes").gameObject:SetActive(true)
		if k == 0 then
			for i = 0, 4 do
				local n = math.ceil(cards[i+1])
				local cardName =string.format("Card_%d_%d",math.modf(n/100),math.fmod(n,100))
				print("自己显示卡牌 "..cardName)
				local card = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex(cardName)
				playerpanel:Find("pokes/poke"..i):GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = card
			end
		end
	end
		
	
end

function this.GetXSeatID(seatid)
	local selfSeatID = NiuNiuCtrl.SeatID
	local xseatid = seatid - selfSeatID
	if xseatid < 0 then
		xseatid = xseatid+6
	end
	return xseatid
end

function this.GetPlayerPanelByXSeatID(xseatid)
	local userspanel = this.transform:Find("players")
	local playerpanel = userspanel:Find("player"..math.ceil(xseatid))
	return  playerpanel
end

function this.DisHostIco(hostid)
	local xhostid = this.GetXSeatID(hostid)
	local playerpanel = this.GetPlayerPanelByXSeatID(xhostid)
	local hostico =this.transform:Find("hostico")
	hostico.position = playerpanel.position + Vector3(-100,40,0)
end

function this.close()
	
end
