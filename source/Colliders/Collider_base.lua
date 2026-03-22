require("Object.lua")
require("Better_shapes.lua")

ColliderBase = {}

function ColliderBase:new(updateble, drawable, data)
	
	obj = Object:new(updatable, drawable, data)
	
	table.insert(currentScene.colliders, obj)
	setmetatable(obj, self)
	self.__index = self; return obj
end