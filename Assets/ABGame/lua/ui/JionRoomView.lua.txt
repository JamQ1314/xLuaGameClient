JionRoomView = {}
local this = JionRoomView


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
	this.transform:Find("bg/left/warming").gameObject:SetActive(false)
end


function this.close()
	
end

function this.ShowKeyboardInput(str)
	--for c in string.gmatch(str,".") do
		
	--end
	for i = 1, 4 do
		v = string.sub(str,i,i)
		this.transform:Find("bg/left/num"..i.."/Text"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text  = v
	end
end


function this.ShowJionRoomFailuerInfo(str)
	local warming = this.transform:Find("bg/left/warming")
	warming.gameObject:SetActive(true)
	warming:GetComponent(typeof(CS.UnityEngine.UI.Text)).text = str
end