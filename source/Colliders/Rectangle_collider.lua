require("Colliders/Collide_checker.lua")
require("Colliders/Collider_base.lua")
require("Better_shapes.lua")

RectangleCollider = {}

function RectangleCollider:new(position, pivot, size, rotation, isVisible, col, mode)
	-- modes: [ 0 = from center ] [ 1 = from left upper point ]
	local mode = mode or 1 -- default
	
	obj = ColliderBase:new(false, true, DATA.collider.rectangleCollider)
	obj.position = position
	obj.pivot = position - pivot
	obj.angle = math.rad(rotation)
	obj.col = col
	obj.mode = mode
	obj.point1 = Vec2.new(position.x - (size.x / 2), position.y - (size.y / 2))
	obj.point2 = Vec2.new(position.x + (size.x / 2), position.y - (size.y / 2))
	obj.point3 = Vec2.new(position.x + (size.x / 2), position.y + (size.y / 2))
	obj.point4 = Vec2.new(position.x - (size.x / 2), position.y + (size.y / 2))
	
	obj.colliders = {
				Vec4.new(obj.point1.x, obj.point1.y, obj.point2.x, obj.point2.y),
				Vec4.new(obj.point2.x, obj.point2.y, obj.point3.x, obj.point3.y),
				Vec4.new(obj.point3.x, obj.point3.y, obj.point4.x, obj.point4.y),
				Vec4.new(obj.point4.x, obj.point4.y, obj.point1.x, obj.point1.y)}
	
	function obj:rotateToBy(angle, zero)
		if(self.mode == 1 and #getCollides(self) == 0) then
			self.point1 = self.point1:rotated(- math.rad(zero) + math.rad(angle), self.pivot)
			self.point2 = self.point2:rotated(- math.rad(zero) + math.rad(angle), self.pivot)
			self.point3 = self.point3:rotated(- math.rad(zero) + math.rad(angle), self.pivot)
			self.point4 = self.point4:rotated(- math.rad(zero) + math.rad(angle), self.pivot)
		end
		self.angle = (math.rad(angle)) % math.pi
		self:update()
	end
	
	function obj:update()
		self.colliders = {
				Vec4.new(self.point1.x, self.point1.y, self.point2.x, self.point2.y),
				Vec4.new(self.point2.x, self.point2.y, self.point3.x, self.point3.y),
				Vec4.new(self.point3.x, self.point3.y, self.point4.x, self.point4.y),
				Vec4.new(self.point4.x, self.point4.y, self.point1.x, self.point1.y)}
	end
	
	function obj:draw()
		if(renderEdges) then
			quad(self.point1, self.point2, self.point3, self.point4, false, self.col)
		else
			quad(self.point1, self.point2, self.point3, self.point4, true, self.col)
		end
	end

	setmetatable(obj, self)
	self.__index = self; return obj
end