require("Object.lua")

Item = {}

function Item:new(x0, y0, data, stack)
	
	obj = Object:new(false, true, data)
	obj.position = Vec2.new(x0, y0)
	obj.colliders = {Vec3.new(x0, y0, data.size)}
	obj.texture = Resources.load(data.spriteDir)
	obj.stack = stack or data.defaultStack

	function obj:draw()
		if(self.texture) then
			tex(self.texture, self.position.x - self.data.size, self.position.y - self.data.size, self.data.size * 2, self.data.size * 2)
		else
			self.texture = Resources.load(DATA.item.unknown.spriteDir)
		end
	end

	table.insert(currentScene.items, obj)
	return obj
end


----------------------ITEM SPAWNER------------------------------
ItemSpawner = {}

function ItemSpawner:new(spawnPoints, itemExample, cooldown)
	
	obj = Object:new(true, true, DATA.other.itemSpawner)
	obj.cooldown = cooldown or obj.data.defaultCooldown
	obj.remaining = 0
	obj.spawnPoints = spawnPoints
	
	obj.spawned = nil
	obj.itemData = itemExample.data
	obj.itemStack = itemExample.stack
	itemExample:removeObject()

	function obj:spawn()
		if(#self.spawnPoints == 1) then
			self.spawned = Item:new(self.spawnPoints[1].x, self.spawnPoints[1].y, self.itemData, self.itemStack) 
		else
			local spawnPosition = spawnPoints[rand:next(1, #self.spawnPoints)]
			self.spawned = Item:new(spawnPosition.x, spawnPosition.y, self.itemData, self.itemStack) 
		end
	end
	
	function obj:update()
		if(type(self.spawned) == type(nil) or type(self.spawned.data) == type(nil)) then
			self.remaining = self.remaining - 1
			if(self.remaining <= 0) then
				self.remaining = self.cooldown
				self:spawn()
			end
		end
	end

	function obj:draw()
		if(#self.spawnPoints == 1) then
			circ(self.spawnPoints[1].x, self.spawnPoints[1].y, self.data.size, false, Color.new(190, 210, 50, 150))
		elseif(renderEdges) then
			for i = 1, #self.spawnPoints do
				circ(self.spawnPoints[i].x, self.spawnPoints[i].y, self.data.size, false, Color.new(190, 210, 50, 150))
			end
		end
	end
	
	table.insert(currentScene.entities, obj)
	return obj
end

Ammo = {}
function Ammo:new(x0, y0, stack)
	obj = Item:new(x0, y0, DATA.item.ammo, stack)
	return obj
end

Medicine = {}
function Medicine:new(x0, y0, stack)
	obj = Item:new(x0, y0, DATA.item.medicine, stack)
	return obj
end

Gear = {}
function Gear:new(x0, y0, stack)
	obj = Item:new(x0, y0, DATA.item.gear, stack)
	return obj
end