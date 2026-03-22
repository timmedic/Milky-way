DelayedCoroutine = {}

function DelayedCoroutine.new(delay, cor, ...)
	
	obj = Object:new(true, false, DATA.other.coroutine.delayedCoroutine)
	obj.delay = delay or 0.01
	obj.cor = cor or nil
	obj.args = {...}
	
	function obj:update()
		if(self.cor) then
			local startTime = DateTime.toSeconds(DateTime.ticks())
			
			while DateTime.toSeconds(DateTime.ticks()) - startTime < self.delay do
				coroutine.resume(self.cor, table.unpack(self.args))
			end
			
			if(coroutine.status(self.cor) == "dead") then
				self:removeObject()
			end
		end
	end
	
	table.insert(currentScene.processes, obj)
	return obj
end