JionRoomCtrl = {}
local this = JionRoomCtrl

local roomid=""

function this.Init()
	require "ui.JionRoomView"
	CS.GApp.UIMgr:Open("prefabs.ui.JionRoomView",this.OnCreate);
	
	if not NiuNiuHandler then
		require "Net.Handler.NiuNiuHandler"
		NiuNiuHandler.Init()
	end
end

function this.OnCreate()
	CS.UIEventListener.Get(JionRoomView.transform:Find("bg/close")).onClick = this.Close
	
	local rightpanel = JionRoomView.transform:Find("bg/right")
	for i = 0,  rightpanel.childCount-1 do
		CS.UIEventListener.Get(rightpanel:GetChild(i)).onClick = this.KeyBoardClick
	end
end

function this.Close(go)
	print(" JionRoomView  close")
	CS.GApp.UIMgr:Close(JionRoomView.transform.name)
end

function this.KeyBoardClick(go)
	if go.name == "del" then
		if #roomid>0 then
			roomid = string.sub(roomid,1,-2)
		end
	elseif go.name == "reset" then
		roomid = ""
	else
		if #roomid < 4 then
			roomid = roomid..go.name
		end
	end

	JionRoomView.ShowKeyboardInput(roomid)
	
	if #roomid ==4 then
		--向服务器发送消息
		local nroomid = tonumber(roomid)
		local simpleint = simplepb.SimpleInt()
		simpleint.simple = nroomid
		local data = simpleint:SerializeToString()
		CS.GApp.NetMgr:Send(0,Main_ID.NiuNiu,NiuNiu_ID.Jion,data)
	end
	
end

function this.ClearKeybordClick()
	roomid = ""
	JionRoomView.ShowKeyboardInput(roomid)
end

function this.JionRoomFailuer(str)
	roomid = ""
	JionRoomView.ShowKeyboardInput(roomid)
	JionRoomView.ShowJionRoomFailuerInfo(str)
end

function this.GetRoomID()
	return roomid
end