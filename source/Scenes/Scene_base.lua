Scene = {}

function Scene:new()
	
	obj = {}
	obj.loaded = false
	obj.processes = {}
	obj.GUI = {}
	obj.entities = {}
	obj.items = {}
	obj.colliders = {}
	obj.tasks = {}
	obj.environment = {}
	obj.scene = {obj.processes, obj.colliders, obj.items, obj.entities, obj.environment, obj.GUI, obj.tasks}
	obj.levelMap = nil
	obj.levelMap_l2 = nil
	
	function obj:loadResources()
	end
	
	function obj:sLoad()
		drawLoadingScreen()
		DATA = loadData()
		self:loadResources()
		self.loaded = true
	end
	
	function obj:sUnload()
		if(self.levelMap) then
			Resources.unload(self.levelMap)
		end
		if(self.levelMap_l2) then
			Resources.unload(self.levelMap_l2)
		end
		for i, objectType in pairs(self.scene) do
			for j, object in pairs(objectType) do
				if(object.removeObject) then
					object:removeObject()
				end
			end
		end
	end
	
	function obj:additionalUpdate()
	end
	
	function obj:updateAllObjects()
		for i, objectType in pairs(self.scene) do
			for j, object in pairs(objectType) do
				if(object.updatable) then
					object:update()
				end
			end
		end
	end
	
	function obj:update()
		self:additionalUpdate()
		self:updateAllObjects()
	end
	
	function obj:additionalDraw()
	end
	
	function obj:drawAllObjects()
		if(self.levelMap) then
			map(self.levelMap, -self.levelMap.width*DATA.game.tileSize/2, -self.levelMap.height*DATA.game.tileSize/2)
		end
		if(self.levelMap_l2) then
			map(self.levelMap_l2, -self.levelMap_l2.width*DATA.game.tileSize/2, -self.levelMap_l2.height*DATA.game.tileSize/2)
		end
		for i, objectType in pairs(self.scene) do
			for j, object in pairs(objectType) do
				if(object.drawable) then
					object:draw()
				end
			end
		end
	end
	
	function obj:draw()
		self:additionalDraw()
		self:drawAllObjects()
	end
	
	function obj:setScene()
		if(currentScene) then
			currentScene:sUnload()
		end
		currentScene = self
		currentScene:sLoad()
	end

	return obj
end