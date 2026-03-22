require("Object.lua")

GUIBase = {}

function GUIBase:new(position, data)
	
	obj = Object:new(false, true, data)
	obj.position = Vec2.new(0, 0)
	if(position.x > 1 or position.y > 1) then
		obj.position = position
	else
		obj.position = Vec2.new(canvasWidth, canvasHeight) * position
	end
	
	function obj:setActive(activeMode)
		self.updatable = activeMode
		self.drawable = activeMode
	end
	
	table.insert(currentScene.GUI, obj)
	setmetatable(obj, self)
	self.__index = self; return obj
end