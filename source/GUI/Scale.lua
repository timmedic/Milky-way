require("GUI/GUI_base.lua")
require("Better_shapes.lua")

Scale = {}

function Scale:new(position, width, value, maxValue, k, fillColor, borderColor, mode)
	-- Modes: [left : from pos to left] [right: from pos to right] [both: from pos to both sides]
	
	obj = GUIBase:new(position, DATA.gui.scale)
	obj.width = width
	obj.value = value
	obj.maxValue = maxValue
	obj.k = k
	obj.fillColor = fillColor
	obj.borderColor = borderColor
	obj.mode = mode or "right"

	function obj:setValue(value)
		if(value < self.maxValue and value >= 0) then
			self.value = value
		elseif(value >= self.maxValue) then
			self.value = maxValue
		end
	end
	
	function obj:draw()
		local drawPosition = self.position + cameraPosition
		local borderWeight = self.width * 0.3
		if(self.mode == "left") then
			weightLine(drawPosition + Vec2.new(borderWeight, 0), drawPosition  + Vec2.new(-self.maxValue / k - borderWeight, 0), self.width+borderWeight*2, true, self.borderColor)
			weightLine(drawPosition, drawPosition  + Vec2.new(-self.value / k, 0), self.width, true, self.fillColor)
		elseif(self.mode == "right") then
			weightLine(drawPosition - Vec2.new(borderWeight, 0), drawPosition  + Vec2.new(self.maxValue / k + borderWeight, 0), self.width+borderWeight*2, true, self.borderColor)
			weightLine(drawPosition, drawPosition  + Vec2.new(self.value / k, 0), self.width, true, self.fillColor)
		elseif(self.mode == "both") then
			weightLine(drawPosition - Vec2.new(self.maxValue / self.k + borderWeight, 0), drawPosition + Vec2.new(self.maxValue / self.k + borderWeight, 0), self.width+borderWeight*2, true, self.borderColor)
			weightLine(drawPosition, drawPosition  + Vec2.new(self.value / k, 0), self.width, true, self.fillColor)
			weightLine(drawPosition, drawPosition  + Vec2.new(-self.value / k, 0), self.width, true, self.fillColor)
		end
	end
	
	setmetatable(obj, self)
	self.__index = self; return obj
end