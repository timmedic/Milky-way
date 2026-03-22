require("Scenes/Scene_base.lua")

MapUpdateTest = Scene:new()

function MapUpdateTest:loadResources()
	TileShader:new()
	
	self.levelMap = Resources.load("testMap.map")
	--self.levelMap_l2 = Resources.load("map_l2.map")
	
	player = Player:new(352, 352)
	cameraFollow(player)

	drawSquare(self.levelMap)
end

function MapUpdateTest:additionalUpdate()
	-- WORLD CHANGING
	--rectangleObject:rotateToBy(2, rectangleObject.angle)
	cameraEaseBoxedFollow(player)
end

function MapUpdateTest:additionalDraw()
end