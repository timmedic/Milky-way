require("Object.lua")

Entity = {}

function Entity:new(x0, y0, data)
	
	obj = Object:new(true, true, data)
	obj.position  = Vec2.new(x0, y0)
	obj.angle = 0
	obj.health = obj.data.health
	obj.sprite = Resources.load(data.spriteDir)
	
	function obj:moveTo(x, y)
		self.position = Vec2.new(x, y)
		self.colliders[1] = Vec3.new(x, y, self.data.size)
	end
	
	function obj:die()
		self:removeObject()
	end

	function obj:takeDamage(damage)
		self.health = self.health - damage
		if(self.health <= 0) then
			self:die()
		end
	end
	
	table.insert(currentScene.entities, obj)
	setmetatable(obj, self)
	self.__index = self; return obj
end