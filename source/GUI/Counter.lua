require("GUI/GUI_base")

Counter = {}

function Counter:new(position, countableObject, count, maxCount, fontSize)
	
	obj = GUIBase:new(position, DATA.gui.counter)
	obj.countableObject = countableObject
	obj.count = count or 0
	obj.maxCount = maxCount or 0
	obj.font = Font.new(nil, DATA.gui.fontSize)
	if(fontSize) then obj.font = Font.new(nil, fontSize) end
	
	function obj:setCount(count)
		self.count = count
	end

	function obj:draw()
		local drawPosition = self.position + cameraPosition
		font(self.font)
		if(self.maxCount == 0) then
			text(countableObject .. ": " .. self.count, drawPosition.x, drawPosition.y)
		elseif(self.maxCount > 0) then
			text(countableObject .. ": " .. self.count .. "/" .. self.maxCount, drawPosition.x, drawPosition.y)
		end
		font()
	end
	
	setmetatable(obj, self)
	self.__index = self; return obj
end