Environment = {}

function Environment:new(dayCycle, color, time)
	
	obj = Object:new(dayCycle, true, DATA.environment.environment)
	obj.color = color or obj.data.defaultColor
	obj.time = time or obj.data.defaultTime
	
	function obj:update()
		self:updateTime()
	end
	
	function obj:updateTime()
		self.time = self.time + 5
		if(self.time >= self.data.timeInDay) then
			self.time = 0
		end
	end
	
	function obj:draw()
		rect(cameraPosition.x - canvasWidth/2, cameraPosition.y - canvasHeight/2, cameraPosition.x + canvasWidth/2, cameraPosition.y + canvasHeight, true, self.color)
		rect(cameraPosition.x - canvasWidth/2, cameraPosition.y - canvasHeight/2, cameraPosition.x + canvasWidth/2, cameraPosition.y + canvasHeight, true, self:processColor())
	end
	
	function obj:processColor()
		local power = math.abs(( (self.time - (self.data.timeInDay/2)) / self.data.timeInDay ))*300
		local sunLight = Color.new(0, 0, 0, power)
		
		return sunLight
	end
	
	table.insert(currentScene.environment, obj)
	return obj
end