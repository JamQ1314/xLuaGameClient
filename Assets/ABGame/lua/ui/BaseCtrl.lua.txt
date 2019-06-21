BaseCtrl = {}
local this = BaseCtrl

function this.Init()
	require "ui.BaseView"
	CS.GApp.UIMgr:Open("prefabs.ui.BaseView",this.OnCreate);
end

function this.OnCreate()
	
end