require("Keyboard.lua")
require("Mouse.lua")
require("Colliders/Collide_checker.lua")
require("Entities/Entity.lua")
require("Entities/Projectile.lua")
require("GUI/Scale.lua")

Player = {}

function Player:new(x0, y0)
	
	obj = Entity:new(x0, y0, DATA.entity.other.player)
	obj.spawnPoint = Vec2.new(x0, y0)
	obj.colliders = {Vec3.new(x0, y0, obj.data.size)}
	
	if(serealizedData.playerHealth) then
		obj.health = serealizedData.playerHealth
	end
	obj.medicine = serealizedData.playerMedicineCount or 0
	obj.ammo = serealizedData.playerAmmoCount or 0
	
	obj.shootSound = Resources.load(obj.data.shootSoundDir, Sfx)
	
	obj.sprintScale = nil
	obj.sprintReload = obj.data.sprintReloadTime
	obj.healthScale = nil
	obj.medicineCounter = nil
	obj.ammoCounter = nil
	
	function obj:takeDamage(damage)
		self:setHealth(self.health - damage)
	end
	
	function obj:setHealth(value)
		self.health = value
		if(self.health <= 0) then
			self:die()
		elseif(self.health > self.data.health) then
			self.health = self.data.health
		end
		self.healthScale:setValue(self.health)
		serealizedData.playerHealth = self.health
	end
	
	function obj:die()
		self.sprintScale:setValue(self.sprintScale.maxValue)
		self.health = self.data.health
		self.spawnPoint = self.spawnPoint or Vec2.new(0, 0)
		self:moveTo(self.spawnPoint.x, self.spawnPoint.y)
	end
	
	function obj:update()
		self:checkGUI()
		self:logic()
	end
	
	function obj:checkGUI()
		if(self.sprintScale == nil) then
			self.sprintScale = Scale:new(Vec2.new(0, 0.45), 4, 500, 500, 2, Color.new(255, 255, 255, 255), Color.new(200, 200, 200, 255), "both")
		end
		if(self.healthScale == nil) then
			self.healthScale = Scale:new(Vec2.new(-0.45, -0.45), 4, self.health, self.data.health, 0.3, Color.new(255, 0, 0, 255), Color.new(150, 0, 0, 255), "right")
		end
		if(self.ammoCounter == nil) then
			self.ammoCounter = Counter:new(Vec2.new(0.3, -0.4), "ammo", self.ammo)
		end
		if(self.medicineCounter == nil) then
			self.medicineCounter = Counter:new(Vec2.new(0.3, -0.45), "medicine", self.medicine)
		end
	end
	
	function obj:logic()
		self:movementLogic()
		self:handleInteractions()
	end
	
	function obj:movementLogic()
		self:turnToMouse()
		self:handleSprint()
		
		if(self:isTryingToMove()) then
			self:tryMoveTowardsWithVelocity(self:getMoveDirection(), self:processVelocity())
		end
	end
	
	function obj:turnToMouse()
		self.angle = Vec2.new(mouseX - self.position.x, mouseY - self.position.y).angle + math.rad(90)
	end
	
	function  obj:isTryingToMove()
		return (key(KeyCode.W) or key(KeyCode.A) or key(KeyCode.S) or key(KeyCode.D))
	end
	
	function obj:tryMoveTowardsWithVelocity(direction, velocity)
		self:handleHorizontalMovement(direction, velocity)
		self:handleVerticalMovement(direction, velocity)
		self:setFinalCollider()
	end
	
	function obj:handleHorizontalMovement(direction, velocity)
		self.colliders[1] = Vec3.new(self.position.x + direction.x * velocity, self.position.y, self.data.size)
		if(#getCollides(self) == 0) then
			self.position = self.position + Vec2.new(direction.x * velocity, 0)
		else
			self:handHandle()
		end
	end
	
	function obj:handleVerticalMovement(direction, velocity)
		self.colliders[1] = Vec3.new(self.position.x, self.position.y + direction.y * velocity, self.data.size)
		if(#getCollides(self) == 0) then
			self.position = self.position + Vec2.new(0, direction.y * velocity)
		else
			self:handHandle()
		end
	end
	
	function obj:setFinalCollider()
		self.colliders[1] = Vec3.new(self.position.x, self.position.y, self.data.size)
	end
	
	function obj:handHandle()
		for i, collide in pairs(getCollides(self)) do
			if(collide.data and collide.data.class == "Item" and collide.data.name) then
				checkTasks(collide.data.name, collide.stack)
				
				if(collide.data.name == "Medicine") then
					self.medicine = self.medicine + collide.stack
					self.medicineCounter:setCount(self.medicine)
					serealizedData.playerMedicineCount = self.medicine
				elseif(collide.data.name == "Ammo") then
					self.ammo = self.ammo + collide.stack
					self.ammoCounter:setCount(self.ammo)
					serealizedData.playerAmmoCount = self.ammo
				end
				
				play(DATA.item.sound.pickup)
				collide.stack = 0
				collide:removeObject()
			end
		end
	end
	
	function obj:getMoveDirection()
		local moveDirection = Vec2.new(0, 0)
			
		if(key(KeyCode.W)) then
			moveDirection.y = -1
		end
		if(key(KeyCode.A)) then
			moveDirection.x = -1
		end
		if(key(KeyCode.S)) then
			moveDirection.y = 1
		end
		if(key(KeyCode.D)) then
			moveDirection.x = 1
		end

		return moveDirection.normalized
	end
	
	function obj:processVelocity()
		local velocity = self.data.speed
		if(isCreative) then velocity = velocity * 2 end
		
		if(self:isSprinting()) then
			velocity = velocity * self.data.boost
			if(isCreative) then velocity = velocity * 2 end
		end
		
		return velocity
	end
	
	function obj:isSprinting()
		return (key(KeyCode.LShift) and self.sprintScale.value > 0)
	end
	
	function obj:handleSprint()
		if(self:isSprinting() and not isCreative) then
			self.sprintReload = self.data.sprintReloadTime
			self.sprintScale:setValue(self.sprintScale.value - 1)
		else
			if(self.sprintReload > 0) then
				self.sprintReload = self.sprintReload - 1
			elseif(self.sprintScale.value < self.sprintScale.maxValue) then
				self.sprintScale:setValue(self.sprintScale.value + 1)
			end
		end
	end
	
	function obj:handleInteractions()
		self:handleMedicineUsage()
		
		if not isCreative then
			self:handleShooting()
			self:handleHitting()
		end
	end
	
	function obj:handleMedicineUsage()
		if(keyClicked(KeyCode.Q) and self.medicine > 0) then
			self:useMedicine()
		end
	end
	
	function obj:useMedicine()
		self.medicine = self.medicine - 1
		self:setHealth(self.health + DATA.item.medicine.healSize)
		self.medicineCounter:setCount(self.medicine)
		serealizedData.playerMedicineCount = self.medicine
	end
	
	function obj:handleShooting()
		if(mouseLeftClicked and self.ammo > 0) then
			self:shootTo(Vec2.new(mouseX, mouseY))
		end
	end
	
	function obj:shootTo(objPosition)
		play(self.shootSound)
		Bullet:new(self.position, objPosition, self)
		self.ammo = self.ammo - 1
		self.ammoCounter:setCount(self.ammo)
		serealizedData.playerAmmoCount = self.ammo
	end
	
	function obj:handleHitting()
		if(mouseRightClicked) then
			local handRange = {}
			local handDot = Vec2.new(self.position.x, self.position.y - self.data.hitDistance):rotated(self.angle, self.position)
			handRange.colliders = {Vec4.new(self.position.x, self.position.y, handDot.x, handDot.y)}
			for i, hitted in pairs(getCollides(handRange)) do
				if(hitted.data.class == "Entity" and hitted.data.entityType == "Enemy") then
					self:hit(hitted)
				end
			end
		end
	end
	
	function obj:hit(object)
		object:takeDamage(self.data.hitDamage)
	end
	
	function obj:draw()
		if(self.sprite) then
			spr(self.sprite, self.position.x - (self.data.size*self.data.sizeModifier), self.position.y - (self.data.size*self.data.sizeModifier), self.data.size*self.data.sizeModifier*2, self.data.size*self.data.sizeModifier*2, self.angle)
		else
			circ(self.position.x, self.position.y, self.size, true, Color.new(255, 200, 200, 255))
		end
		
		if not isCreative then
			if(mouseLeftClicked) then
				
			elseif(mouseRightClicked) then
				local handDot = Vec2.new(self.position.x, self.position.y - self.data.hitDistance):rotated(self.angle, self.position)
				weightLine(self.position, handDot, self.data.hitDistance/2, true, Color.new(255, 100, 10, 100))
			end
		end
	end
	
	setmetatable(obj, self)
	self.__index = self; return obj
end