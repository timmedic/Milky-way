require("Scenes/Scene_base.lua")

StoryLevel0 = Scene:new()

function StoryLevel0:loadResources()
	self.levelMap = Resources.load("Levels/Story/level0_l1.map")
	self.levelMap_l2 = Resources.load("Levels/Story/level0_l2.map")
	TileShader:new()
	
	spider = CommonSpider:new(270, 0, false, false, {Vec2.new(270, -200), Vec2.new(280, -200), Vec2.new(270, 150), Vec2.new(280, 150)})
	localPlayer = Player:new(16, 16)
	
	-- WORLD OBJECTS --
	Medicine:new(-112, -208)

	-- WORLD COLLIDERS --
	ClosedPolylineCollider:new({Vec2.new(192.0, -64.0), Vec2.new(224.0, -64.0), Vec2.new(224.0, -160.0), Vec2.new(32.0, -160.0), Vec2.new(32.0, -256.0), Vec2.new(-160.0, -256.0), Vec2.new(-160.0, 128.0), Vec2.new(224.0, 128.0), Vec2.new(224.0, 0.0), Vec2.new(192.0, 0.0), Vec2.new(192.0, 96.0), Vec2.new(-128.0, 96.0), Vec2.new(-128.0, -224.0), Vec2.new(0.0, -224.0), Vec2.new(0.0, -128.0), Vec2.new(192.0, -128.0)}, Color.new(0, 0, 0, 0))
end

function StoryLevel0:additionalUpdate()
	cameraEaseBoxedFollow(localPlayer)
end

function StoryLevel0:additionalDraw()
end