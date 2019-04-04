LobbyHandler = {}
local this = LobbyHandler

function this.Init()
	CS.GApp.NetMgr:RegisterHandler(Main_ID.Lobby,this.HandleMsg)
end

function this.HandleMsg(sid,bytes)

	if sid==Lobby_ID.LoginSuccess then
		LobbyHandler.DoLoginSuccess(bytes)
	end
end

function this.DoLoginSuccess(bytes)
	local user = userpb.User()
	user:ParseFromString(bytes)
	--保存数据
	GameCache.userinfo = user
	CS.PlayerPrefsSaveValue.SetInt("visitorid",user.id)
	print("登陆成功 :" ..user.id .."   "..user	.name)
	--加载大厅
	CS.GApp.UIMgr:CloseAll()
	require "ui.LobbyCtrl"
	LobbyCtrl.Init()
end