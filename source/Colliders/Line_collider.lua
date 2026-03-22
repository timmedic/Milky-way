require("Colliders/Collide_checker.lua")
require("Colliders/Collider_base.lua")
require("Better_shapes.lua")

LineCollider = {}

function LineCollider:new(point1, point2, col)
	
	obj = ColliderBase:new(false, true, DATA.collider.lineCollider)
	obj.point1 = point1
	obj.point2 = point2
	obj.colliders = { Vec4.new(obj.point1.x, obj.point1.y, obj.point2.x, obj.point2.y) }
	obj.col = col
	
	function obj:rotateToBy(angle, zero)
		local pivot = (self.point1 + self.point2) * 0.5
		self.point1 = self.point1:rotated(- math.rad(zero) + math.rad(angle), pivot)
		self.point2 = self.point2:rotated(- math.rad(zero) + math.rad(angle), pivot)
		self.angle = (math.rad(angle)) % math.pi
		self:update()
	end
	
	function obj:update()
		self.colliders = { Vec4.new(self.point1.x, self.point1.y, self.point2.x, self.point2.y) }
	end
	
	function obj:draw()
		if(renderEdges) then
			line(self.point1.x, self.point1.y, self.point2.x, self.point2.y, Color.new(self.col.r, self.col.g, self.col.b, 255))
		else
			line(self.point1.x, self.point1.y, self.point2.x, self.point2.y, self.col)
		end
	end

	setmetatable(obj, self)
	self.__index = self; return obj
end