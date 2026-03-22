require("Entities/Entity.lua")

Projectile = {}

function Projectile:new(startPos, endPos, data, owner)
	
	obj = Entity:new(startPos.x, startPos.y, data)
	obj.owner = owner
	obj.targetPos = endPos
	obj.colliders = {Vec3.new(x0, y0, obj.data.size+2)}
	obj.velocity = Vec2.new(obj.data.speed * math.cos((endPos - startPos).angle), obj.data.speed * math.sin((endPos - startPos).angle))
	
	function obj:die()
		self.owner = nil
		self:removeObject()
	end
	
	function obj:update()
		if(self.position:distanceTo(Vec2.new(0, 0)) >= 100) then
			self.removeObject()
		end
		
		self.position = self.position + self.velocity
		self.colliders[1] = Vec3.new(self.position.x, self.position.y, self.data.size+2)

		for i, hit in pairs(getCollides(self)) do
			if(hit ~= self.owner) then
				if(hit.data.class == "Entity") then
					hit:takeDamage(self.data.hitDamage)
				end
				self:die()
				break
			end
		end
	end
	
	function obj:draw()
		circ(self.position.x, self.position.y, self.data.size, true, self.data.color)
	end
	
	setmetatable(obj, self)
	self.__index = self; return obj
end

Bullet = {}
function Bullet:new(startPos, endPos, owner)
	obj = Projectile:new(startPos, endPos, DATA.entity.projectile.bullet, owner)
	return obj
end

CobwebShell = {}
function CobwebShell:new(startPos, endPos, owner)
	obj = Projectile:new(startPos, endPos, DATA.entity.projectile.cobwebShell, owner)
	return obj
end