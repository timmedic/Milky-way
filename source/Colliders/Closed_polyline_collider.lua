require("Colliders/Collider_base.lua")
require("Better_shapes.lua")

ClosedPolylineCollider = {}

function ClosedPolylineCollider:new(points, col)
	
	obj = ColliderBase:new(false, true, DATA.collider.closedPolylineCollider)
	obj.points = points
	obj.col = col
	obj.isVisible = true
	obj.colliders = {}
	for i = 1, #points - 1 do
		table.insert(obj.colliders, Vec4.new(points[i].x, points[i].y, points[i+1].x, points[i+1].y))
	end
	table.insert(obj.colliders, Vec4.new(points[#points].x, points[#points].y, points[1].x, points[1].y))
	
	if(obj.col.a == 0) then
		obj.isVisible = false
		obj.col = Color.new(col.r, col.g, col.b, 255)
	end
	
	function obj:draw()
		if(renderEdges or self.isVisible) then
			for i = 1, #self.points - 1 do
				line(self.points[i].x, self.points[i].y, self.points[i+1].x, self.points[i+1].y, self.col)
			end
			line(self.points[#self.points].x, self.points[#self.points].y, self.points[1].x, self.points[1].y, self.col)
		end
	end

	setmetatable(obj, self)
	self.__index = self; return obj
end