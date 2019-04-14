local util = require 'util.util'

local gameobject = CS.UnityEngine.GameObject('CoroutineRunner')
CS.UnityEngine.Object.DontDestroyOnLoad(gameobject)
local cs_coroutine_runner = gameobject:AddComponent(typeof(CS.CoroutineRunner))

return {
	start = function(...)
		return cs_coroutine_runner:StartCoroutine(util.cs_generator(...))
	end;
	
	stop = function(coroutine)
		cs_coroutine_runner:StopCoroutine(coroutine)
	end
}