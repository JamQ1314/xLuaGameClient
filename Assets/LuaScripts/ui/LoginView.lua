---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2019/1/18 10:44
---


LoginView = {}
local this = LoginView

local transform
local gameobject

print("LoginView.lua.txt");

function this.awake(go)
	print("LoginView.awake : "..go.name)
    transform = go.transform
    gameobject = go;
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
	goAccLoginPanel = transform:Find("bg/accLogin").gameObject
	goAccLoginPanel:SetActive(true)
end
	


