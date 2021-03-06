NiuNiuView = {}
local this = NiuNiuView
local AllPlayerPanels = {} 

local noReadySprite
local ReadySprite 
function this.awake(go)
	this.transform = go.transform
	this.gameobject = go
end

function  this.start()
	
end

function  this.update()
	
end

function  this.ondestroy()
	
end

function this.open()
	AllPlayerPanels = {}
	noReadySprite = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex("moren")
	ReadySprite = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex("dangqian")
	
	this.transform:Find("roominfo/roomid"):GetComponent("UnityEngine.UI.Text").text = "房号:"..NiuNiuCtrl.RoomID
	--显示自身信息 隐藏其他角色
	local userinfo = GameCache.userinfo
	local userspanel = this.transform:Find("players")
	--获取为准备头像框
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
	playerpanel:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = ReadySprite
	
	if xseatid == 0 then
		--隐藏准备按钮
		this.transform:Find("readybtn").gameObject:SetActive(false)
	end
end

function this.GameDeal(cards)
	this.transform:Find("bpoke"):GeComponent(typeof(CS.UnityEngine.AudioSource)):Play()
	for k, v in pairs(AllPlayerPanels) do
		local playerpanel = v
		playerpanel:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = noReadySprite
		playerpanel:Find("pokes").gameObject:SetActive(true)
		playerpanel:Find("pokes/nntype").gameObject:SetActive(false)
		
		if k == 0 then
			for i = 0, 4 do
				local n = math.ceil(cards[i+1])
				local cardName =string.format("Card_%d_%d",math.modf(n/100),math.fmod(n,100))
				--print("自己显示卡牌 "..cardName)
				local card = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex(cardName)
				playerpanel:Find("pokes/poke"..i):GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = card
			end
		else
			for i = 0, 4 do
				local cardName ="Card_0_0"
				--print("自己显示卡牌 "..cardName)
				local card = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex(cardName)
				playerpanel:Find("pokes/poke"..i):GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = card
			end
		end
		
	end
end


function this.GameLay(allcards)
	local hostid = NiuNiuCtrl.HostID
	co_runner.start(function ()
			for i = 0, 5 do
				local id = hostid +i
				if id>5 then
					id = id - 6
				end
				if allcards[id] ~= nil then
					local xseatid = this.GetXSeatID(id)
					local playerpanel = this.GetPlayerPanelByXSeatID(xseatid)
					local pokepanel = playerpanel:Find("pokes")
					for i = 0, 4 do
						local n = math.ceil(allcards[id].cards[i+1])
						local cardName =string.format("Card_%d_%d",math.modf(n/100),math.fmod(n,100))
						local card = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex(cardName)
						local pokeName = "poke"..i
						local poke = pokepanel:Find("poke"..i)
						local pokesprite = poke:GetComponent(typeof(CS.UnityEngine.UI.Image))
						pokesprite.sprite = card
					end
					local nntypename = "niu_"..math.ceil(allcards[id].nntype)
					local nntypesprite = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetTex(nntypename)
					local uinntype = pokepanel:Find("nntype")
					uinntype.gameObject:SetActive(true)
					uinntype:GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = nntypesprite
					
					local nntypesoundname = "manbull"..math.ceil(allcards[id].nntype)
					local nntypesound = this.transform:GetComponent(typeof(CS.GameAssetsContainer)):GetSound(nntypesoundname)
					local audio = playerpanel:GetComponent(typeof(CS.UnityEngine.AudioSource))
					audio.clip = nntypesound
					audio:Play()
					coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
				end
			end
			--显示结果
			local selfcards = allcards[NiuNiuCtrl.SeatID]
			local resultpanel = this.transform:Find("result")
			local result
			if selfcards.xgold >0 then
				result = resultpanel:Find("win")
			else
				result = resultpanel:Find("lose")
			end
			result.gameObject:SetActive(true)
			result:Find("Text"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text = math.ceil(selfcards.xgold)
			local audio = result:GetComponent(typeof(AudioSource))
			audio:Play()
		
			--金币跳动
			this.XGold(allcards)
			--等待音效
			coroutine.yield(CS.UnityEngine.WaitForSeconds(6))
			audio:Stop()
			result.gameObject:SetActive(fale)
			
			--初始化
			this.NextGame()
	end)
end

function  this.XGold(allcards)
	for i = 0, 5 do
		if allcards[i]~= nil then
			local xseatid = this.GetXSeatID(i)
			local playerpanel = this.GetPlayerPanelByXSeatID(xseatid)
			local goldScript = playerpanel:Find("goldtx"):GetComponent(typeof(CS.Gold))
			goldScript:XGold(math.ceil(allcards[i].xgold))
		end
	end
end

function this.NextGame()
	for k, v in pairs(AllPlayerPanels) do
		local playerpanel = v
		playerpanel:Find("pokes").gameObject:SetActive(fales)
	end
	this.transform:Find("readybtn").gameObject:SetActive(true)
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
