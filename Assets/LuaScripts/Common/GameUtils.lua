
GameUtils = {}

local function StartCoroutine(url,onload)
	co_runner.start(function (url)
			coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
			local w = WWW("file:///d:/logo.jpg")
			coroutine.yield(w)
			onload()
		end)
end 

GameUtils.StartCoroutine = StartCoroutine
return GameUtils





