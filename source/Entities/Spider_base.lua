require("Entities/Entity.lua")
require("Colliders/Collide_checker.lua")

Spider = {}

function Spider:new(x0, y0, alwaysSeePlayer, stray, patrolPoints, spiderData)
	local generalData = DATA.entity.enemy.spider
	
	obj = Enemy:new(x0, y0, spiderData)
	obj.colliders = {Vec3.new(x0, y0, obj.data.size)}
	obj.target = nil
	obj.alwaysSeePlayer = alwaysSeePlayer or false
	obj.stray = stray or false
	obj.patrolPoints = patrolPoints or {obj.position}
	obj.currentPatrolPointNum = 0
	obj.waitingTime = 0
	
	function obj:takeDamage(damage)
		self.health = self.health - damage
		self:setTarget(self:getNearestPlayer())
		if(self.health <= 0) then
			self:die()
		end
	end
	
	function obj:die()
		checkTasks(self.data.name, 1)
		if(self.target.object.data.name == "Player") then
			self.target = nil
		end
		self:removeObject()
	end
	
	function obj:update()
		self:logic()
	end
	
	function obj:logic()
		self:checkTargetExisting()
		self:patrolLogic()
		self:playerDetectionLogic()
		self:movementLogic()
	end
	
	function obj:checkTargetExisting()
		if(not self.target) then
			self.target = Point:new(self.position.x, self.position.y)
			self.target.object = self.target
		end
	end
	
	function obj:patrolLogic()
		if(self.waitingTime > 0 and self.waitingTime ~= -1) then
			self.waitingTime = self.waitingTime - 1
		end
		if(self.waitingTime <= 0 and self.waitingTime ~= -1) then
			if(self.stray) then
				local strayOffset = Vec2.new(rand:next(-100, 100), rand:next(-100, 100)).normalized * generalData.strayRadius
				self:setTarget(Point:new(self.patrolPoints[1].x + strayOffset.x, self.patrolPoints[1].y + strayOffset.y))
				self.waitingTime = strayOffset.length / (self.data.speed * 0.3) + generalData.strayDelay
			else
				if(#self.patrolPoints == 1) then
					self:setTarget(Point:new(self.patrolPoints[1].x, self.patrolPoints[1].y))
					self.waitingTime = -1
				else
					local nextPoint = self:getNextPoint()
					self:setTarget(Point:new(nextPoint.x, nextPoint.y))
					self.waitingTime = (self.position:distanceTo(nextPoint) / (self.data.speed * 0.5)) + generalData.patrolDelay
				end
			end
		end
	end
	
	function obj:getNextPoint()
		self.currentPatrolPointNum = (self.currentPatrolPointNum % #self.patrolPoints) + 1
		return self.patrolPoints[self.currentPatrolPointNum]
	end
	
	function obj:playerDetectionLogic()
		if(not isCreative) then
			if(self.alwaysSeePlayer) then
				self.waitingTime = generalData.waitingTime
				self:setTarget(self:getNearestPlayer())
			else
				for i, player in pairs(self:getPlayers()) do
					local distanceToPlayer = self.position:distanceTo(player.position)
					if(distanceToPlayer <= self.data.flairDistance or (distanceToPlayer <= self.data.visionDistance and self:isCanSeeThis(player))) then
						self.waitingTime = generalData.waitingTime
						self:setTarget(player)
					end
				end
			end
		end
	end
	
	function obj:setTarget(target)
		self.target.position = target.position
		self.target.object = target
	end
	
	function obj:getNearestPlayer()
		local minDist = nil
		local nearestPlayer = nil
		for i, player in pairs(self:getPlayers()) do
			local distance = self.position:distanceTo(player.position)
			if(not nearestPlayer or distance < minDist) then
				minDist = distance
				nearestPlayer = player
			end
		end
		return nearestPlayer
	end
	
	function obj:getPlayers()
		local players = {}
		for i, object in pairs(currentScene.entities) do
			if(object.data and object.data.name == DATA.entity.other.player.name) then
				table.insert(players, object)
			end
		end
		return players
	end
	
	function obj:isCanSeeThis(object)
		--checks the vision area
		if(math.cos(Vec2.new(object.position.x - self.position.x, object.position.y - self.position.y).angle - self.angle) < math.cos(self.data.visionAngle/2)) then
			return false
		end
		
		if(self:isHasBarrierTo(object)) then
			return false
		end
		return true
	end
	
	function obj:isHasBarrierTo(object)
		local raycast = Vec4.new(self.position.x, self.position.y, object.position.x, object.position.y)
		for _, collide in pairs(getCollides({colliders={raycast}})) do
			if(collide.data and collide.data.class == "Collider") then
				return true
			end
		end
		return false
	end
	
	function obj:movementLogic()
		self:turnToTarget()
		self:handleHittings()
		
		if(self:isNeedsGoNext()) then
			self:tryMoveTo(self:getNextPosition())
		else
			self.sprite:play("idle")
		end
	end
	
	function obj:turnToTarget()
		self.angle = Vec2.new(self.target.position.x - self.position.x, self.target.position.y - self.position.y).angle
	end
	
	function obj:handleHittings()
		if(self.cdForHit > 0) then
			self.cdForHit = self.cdForHit - 1
		elseif(self.target.object.data.name == "Player") then
			if(self:isMayHitThis(self.target.object)) then
				self.cdForHit = self.data.hitCd
				self:hit(self.target.object)
			end
		end
	end
	
	function obj:isMayHitThis(object)
		if (not object or not object.position) then print("ERROR: no object or pos") return end
		return (self.target.position == object.position) and (self.position:distanceTo(object.position) < self.data.hitDistance) and not self:isHasBarrierTo(object)
	end
	
	function obj:hit(object)
		object:takeDamage(self.data.hitDamage)
	end
	
	function obj:isNeedsGoNext()
		return (self.position:distanceTo(self.target.position) >= self.data.speed * 2)
	end
	
	function obj:tryMoveTo(nextPosition)
		self.colliders[1] = Vec3.new(nextPosition.x, nextPosition.y, self.data.size)

		if not(self:isNextPositionBlocked()) then
			self.sprite:play("run", false)
			self.position = nextPosition
		else
			self.sprite:play("idle")
		end
		
		self.colliders[1] = Vec3.new(self.position.x, self.position.y, self.data.size)
	end
	
	function obj:isNextPositionBlocked()
		return self:isTouchingPlayer()
	end
	
	function obj:isTouchingPlayer()
		local isHittingPlayer = false
		for i, object in pairs(getCollides(self)) do
			if(object.data.name == "Player") then
				isHittingPlayer = true
			end
		end

		return isHittingPlayer
	end
	
	function obj:getNextPosition()
		local posOffset = Vec2.new(0, 0)
		
		posOffset.x = self.data.speed * math.cos((self.target.position - self.position).angle)
		posOffset.y = self.data.speed * math.sin((self.target.position - self.position).angle)

		local k = 1
		if(#getCollides(self) > 0) then
			k = 0.6
		end
		
		return (self.position + posOffset.normalized * self.data.speed * k)
	end
	
	function obj:draw()
		if(self.sprite) then
			spr(self.sprite, self.position.x - (self.data.size*generalData.sizeModifier), self.position.y - (self.data.size*generalData.sizeModifier), self.data.size*generalData.sizeModifier*2, self.data.size*generalData.sizeModifier*2, self.angle +  math.rad(90), nil, self.data.color)
		else
			circ(self.position.x, self.position.y, self.size, true, Color.new(0, 0, 0, 255))
		end

		if (debugMode and not self.alwaysSeePlayer) then
			pie(self.position.x, self.position.y, self.data.visionDistance, self.angle - self.data.visionAngle/2, self.angle + self.data.visionAngle/2, false, Color.new(200, 0, 0))
			circ(self.position.x, self.position.y, self.data.flairDistance, false, Color.new(100, 0, 0))
		end
	end
	
	return obj
end