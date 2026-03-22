Tramway = {}

function Tramway:new(position, customMessage)
	
	obj = Object:new(true, true, DATA.other.tramway)
	obj.position = position
	obj.texture = Resources.load(DATA.other.tramway.spriteDir)
	obj.used = false
	obj.message = customMessage or obj.data.defaultMessage
	
	function obj:update()
		if(localPlayer and self.position:distanceTo(localPlayer.position) <= self.data.usageRadius) then
			if(self.used == false) then
				if(isAllTasksCompleted()) then
					if(gamemode == gamemodes.story and currentLevel < #DATA.game.levels.story) then
						currentLevel = currentLevel + 1
						DATA.game.levels.story[currentLevel].scene:setScene()
					elseif(gamemode == gamemodes.arcade and currentLevel < #DATA.game.levels.arcade) then
						currentLevel = currentLevel + 1
						DATA.game.levels.arcade[currentLevel].scene:setScene()
					elseif(gamemode == gamemodes.test and currentLevel < #DATA.game.levels.test) then
						currentLevel = currentLevel + 1
						DATA.game.levels.test[currentLevel].scene:setScene()
					else
						TextBox:new(Vec2.new(0, 0.4), self.data.noStopsMessage, 2*60)
					end
				else
					TextBox:new(Vec2.new(0, 0.4), self.message, string.len(self.message)*10)
				end
			end
			self.used = true
		else
			self.used = false
		end
	end
	
	function obj:draw()
		circ(self.position.x, self.position.y, self.data.usageRadius, true, Color.new(255, 255, 255, 50))
		if(self.texture) then
			tex(self.texture, self.position.x - (DATA.game.tileSize/2) + 1, self.position.y - (DATA.game.tileSize*2), DATA.game.tileSize, DATA.game.tileSize*4)
		else
			rect(self.position.x - (DATA.game.tileSize/2)+2, self.position.y - (DATA.game.tileSize*2)-2, self.position.x + (DATA.game.tileSize/2)-2, self.position.y + (DATA.game.tileSize*2)+2, true, Color.new(100, 100, 100))
		end
	end

	table.insert(currentScene.entities, obj)
	setmetatable(obj, self)
	self.__index = self; return obj
end