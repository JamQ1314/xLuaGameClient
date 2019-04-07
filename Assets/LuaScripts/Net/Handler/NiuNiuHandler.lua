NiuNiuHandler = {}
local this = NiuNiuHandler

function this.Init()
	CS.GApp.NetMgr:RegisterHandler(Main_ID.NiuNiu,this.HandleMsg)
end

function this.HandleMsg(sid,bytes)
	
end