CommonTest ={}
local this = CommonTest

function this.DoTest()
	
end



function wait()
	while true do
		print('i am coroutine wait')
		coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
	end
end

local cofun = coroutine.create(wait) 



--携程开启方法1
--co_runner.start(wait)

--携程开启方法2 暂时无法实现
--runner:YieldAndCallback(cofun)