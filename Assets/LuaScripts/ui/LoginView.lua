LoginView = {}
local this = LoginView

GoLoginPanel = nil
text_logininfo = nil
text_loginacc = nil
text_loginpwd = nil

GoRegisterPanel = nil
text_registerinfo = nil
text_registeracc = nil
text_registerpwd = nil
text_registerpwda = nil


function this.awake(go)
    this.transform = go.transform
	this.gameobject = go;
	GoLoginPanel = this.transform:Find("bg/accLogin")
	text_logininfo = GoLoginPanel:Find("errtext"):GetComponent(typeof(CS.UnityEngine.UI.Text));
	text_loginacc = GoLoginPanel:Find("accText"):GetComponent(typeof(CS.UnityEngine.UI.InputField));
	text_loginpwd = GoLoginPanel:Find("pwdText"):GetComponent(typeof(CS.UnityEngine.UI.InputField));
	
	GoRegisterPanel = this.transform:Find("bg/accRegister")
	text_registerinfo = GoRegisterPanel:Find("errtext"):GetComponent(typeof(CS.UnityEngine.UI.Text));
	text_registeracc = GoRegisterPanel:Find("accText"):GetComponent(typeof(CS.UnityEngine.UI.InputField));
	text_registerpwd = GoRegisterPanel:Find("pwdText"):GetComponent(typeof(CS.UnityEngine.UI.InputField));
	text_registerpwda = GoRegisterPanel:Find("pwdTextA"):GetComponent(typeof(CS.UnityEngine.UI.InputField));
	
end

function  this.start()
	
end

function  this.update()

end

function  this.ondestroy()

end


function this.open()
	
	--this.setmode(1)
	--text_registeracc.text = "xyz"
	--text_registerpwd.text = "xyz"
	--text_registerpwda.text = "xyz
	this.setmode(0)
	text_loginacc.text = "admin"
	text_loginpwd.text = "admin"
	LoginCtrl.TexBytes = nil;
end

function this.setmode(mode)
	local status = true
	if mode==0 then
		status = true
	else
		status = false
	end
	this.ClearPanelInfo()
	GoLoginPanel.gameObject:SetActive(status)
	GoRegisterPanel.gameObject:SetActive(not status)
end

 function this.ClearPanelInfo()
	text_logininfo.text = ""
	text_loginacc.text = ""
	text_loginpwd.text = ""
	text_registeracc.text = ""
	text_registerpwd.text = ""
	text_registerpwda.text = ""
	text_registerinfo.text = ""
end

function this.GetGo(goname)

	local tmp = this.transform:Find(goname)
 	return this.transform:Find(goname)
end

function this.GetLoginInfo()
	
end


function this.GetRegisterInfo()
	local acc = text_registeracc.text
	if string.len(acc) ==0 then
		this.ClearPanelInfo()
		text_registerinfo.text = "账号不能为空"
		return 
	else
		if string.find(acc,"钱") ~= nil and string.find(acc,"杰") ~= nil then
			this.ClearPanelInfo()
			text_registerinfo.text = "账号不符合规定"
			return
		else
			if  string.find(acc,"爸爸") ~= nil  then
				this.ClearPanelInfo()
				text_registerinfo.text = "账号不符合规定"
				return
			end	
		end
	end

	local pwd0 = text_registerpwd.text
	local pwd1 = text_registerpwda.text
	if pwd0 =="" then
		this.ClearPanelInfo()
		text_registerinfo.text = "密码不能为空"
	else
		if pwd0 ~=pwd1 then
			this.ClearPanelInfo()
			text_registerinfo.text = "两次密码不一样"
			return
		end
	end	
	
	if LoginCtrl.TexBytes == nil then
		text_registerinfo.text = "请选择头像"
	end
	return acc,pwd0
end