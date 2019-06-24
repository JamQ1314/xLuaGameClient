Socket_ID={
	Common = 0,
}

Main_ID = {
	Lobby = 1,
	NiuNiu = 2,
	}

Lobby_ID = {
	AccLogin = 1,
	AccRegister = 2,
	WxLogin = 3,
	VisitorLogin = 4,
	-- 回调 100 起
	LoginSuccess = 101
	
	}
NiuNiu_ID = {
	Create = 1,
	Jion =2,
	Leave =3,
	Ready =4,
	TimeCount = 5,
	
	
	CreateSuccess = 101,
	JionSuccess = 102,
	JionFailure = 103,
	PlayerJion = 104,
	LeaveSuccess = 105,
	LeaveFailure = 106,
	ReadySuccess = 107,
	TurnHost = 108, -- 换装
	GameDeal = 109, -- 发牌
	TimeCount = 110, -- 倒计时
	GameLay = 111, --亮牌
	}