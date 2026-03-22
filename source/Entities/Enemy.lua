require("Entities/Entity.lua")

Enemy = {}

function Enemy:new(x0, y0, data)
	health = health or maxHealth
	
	obj = Entity:new(x0, y0, data)
	
	obj.cdForHit = 0
	
	setmetatable(obj, self)
	self.__index = self; return obj
end