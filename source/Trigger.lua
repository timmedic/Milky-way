Trigger = {}

function Trigger:new(position, radius, reusable)
	
	obj = Object:new(true, true)
	obj.position = position
	obj.radius = radius or DATA.game.tileSize
	obj.reusable = reusable or false
	obj.used = false
	
	function obj:doAction()
		print("no action")
	end
	
	function obj:use()
		self:doAction()
		if(not reusable) then
			self:removeObject()
		end
	end
	
	function obj:update()
		if(localPlayer and self.position:distanceTo(localPlayer.position) <= self.radius) then
			if(not self.used) then
				self:use()
				self.used = true
			end
		else
			self.used = false
		end
	end
	
	function obj:draw()
		if(debugMode) then
			circ(self.position.x, self.position.y, self.radius, true, Color.new(255, 255, 255, 100))
		end
	end
	
	table.insert(currentScene.entities, obj)
	return obj
end