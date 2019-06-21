LoginView = {}
local this = LoginView

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
	
end

function this.AccLoginPanel()
	print("显示账号登陆界面")
	goAccLoginPanel = this.transform:Find("bg/accLogin").gameObject
	goAccLoginPanel:SetActive(true)
end
	



