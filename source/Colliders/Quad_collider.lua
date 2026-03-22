require("Colliders/Collider_base.lua")
require("Better_shapes.lua")

QuadCollider = {}

function QuadCollider:new(point1, point2, point3, point4, col, isFilled, isVisible)
	
	obj = ColliderBase:new(false, true, DATA.collider.quadCollider)
	obj.point1 = point1
	obj.point2 = point2
	obj.point3 = point3
	obj.point4 = point4
	obj.col = col
	obj.isFilled = isFilled or false
	obj.isVisible = isVisible or false
	obj.colliders = {
				Vec4.new(point1.x, point1.y, point2.x, point2.y),
				Vec4.new(point2.x, point2.y, point3.x, point3.y),
				Vec4.new(point3.x, point3.y, point4.x, point4.y),
				Vec4.new(point4.x, point4.y, point1.x, point1.y)}
	
	function obj:draw()
		if(renderEdges) then
			quad(self.point1, self.point2, self.point3, self.point4, false, self.col)
		elseif(self.isVisible) then
			if(self.isFilled) then
				quad(self.point1, self.point2, self.point3, self.point4, true, self.col)
			else
				line(point1.x, point1.y, point2.x, point2.y, col)
				line(point2.x, point2.y, point3.x, point3.y, col)
				line(point3.x, point3.y, point4.x, point4.y, col)
				line(point4.x, point4.y, point1.x, point1.y, col)
			end
		end
	end

	setmetatable(obj, self)
	self.__index = self; return obj
end