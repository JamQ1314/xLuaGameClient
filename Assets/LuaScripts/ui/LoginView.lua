LoginView = {}
local this = LoginView

function this.awake(go)
	print("LoginView.awake : "..go.name)
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
	print("call back LoginView.open");
end

function this.AccLoginPanel()
	print("显示账号登陆界面")
	goAccLoginPanel = this.transform:Find("bg/accLogin").gameObject
	goAccLoginPanel:SetActive(true)
end
	



