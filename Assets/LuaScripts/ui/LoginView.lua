LoginView = {}
local this = LoginView

GoLoginPanel = nil
GoRegisterPanel = nil

function this.awake(go)
    this.transform = go.transform
	this.gameobject = go;
	GoLoginPanel = this.transform:Find("bg/accLogin")
	GoRegisterPanel = this.transform:Find("bg/accRegister")
end

function  this.start()
  
end

function  this.update()

end

function  this.ondestroy()

end


function this.open()
	this.setmode(1)
end

function this.setmode(mode)
	local status = true
	if mode==0 then
		status = true
	else
		status = false
	end
	GoLoginPanel.gameObject:SetActive(status)
	GoRegisterPanel.gameObject:SetActive(not status)
end

function this.GetGo(goname)

	local tmp = this.transform:Find(goname)
 	return this.transform:Find(goname)
end

function this.GetLoginInfo()
	
end

function this.GetRegisterInfo()
	local acc = GoRegisterPanel:Find("accText"):GetComponent(typeof(CS.UnityEngine.UI.InputField)).text;
	local pwd0 = GoRegisterPanel:Find("pwdText"):GetComponent(typeof(CS.UnityEngine.UI.InputField)).text;
	local pwd1 = GoRegisterPanel:Find("pwdText"):GetComponent(typeof(CS.UnityEngine.UI.InputField)).text;
	local rinfo = CS.LCCFunction.MatchAccout(acc)
	if rinfo~="" then
		
	end
end

	



