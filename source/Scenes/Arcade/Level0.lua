require("Scenes/Scene_base.lua")

ArcadeLevel0 = Scene:new()

function ArcadeLevel0:loadResources()
	--PixelShader:new()
	TileShader:new()
	Environment:new(true)
	
	self.levelMap = Resources.load("Levels/Arcade/level0_l1.map")
	self.levelMap_l2 = Resources.load("Levels/Arcade/level0_l2.map")
	DelayedCoroutine.new(nil, coroutine.create(corRadndomizeSpecTiles), self.levelMap)
	
	ItemSpawner:new({Vec2.new(992.0, 352.0), Vec2.new(608.0, 896.0), Vec2.new(-64.0, 608.0)}, Ammo:new())
	ItemSpawner:new({Vec2.new(96.0, 832.0), Vec2.new(544.0, 480.0), Vec2.new(608.0, 128.0), Vec2.new(160.0, 64.0)}, Ammo:new())
	ItemSpawner:new({Vec2.new(96.0, 192.0), Vec2.new(992.0, 224.0), Vec2.new(736.0, 800.0)}, Medicine:new())
	CommonSpiderSpawner:new({Vec2.new(608.0, 800.0), Vec2.new(128.0, 512.0), Vec2.new(544.0, 192.0)}, nil, DATA.entity.enemy.commonSpider)

	ClosedPolylineCollider:new({Vec2.new(-96.0, -32.0), Vec2.new(1280.0, -32.0), Vec2.new(1280.0, 992.0), Vec2.new(-96.0, 992.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(864.0, 320.0), Vec2.new(896.0, 320.0), Vec2.new(896.0, 192.0), Vec2.new(1024.0, 192.0), Vec2.new(1024.0, 256.0), Vec2.new(1056.0, 256.0), Vec2.new(1056.0, 288.0), Vec2.new(1024.0, 288.0), Vec2.new(1024.0, 416.0), Vec2.new(1088.0, 416.0), Vec2.new(1088.0, 448.0), Vec2.new(1120.0, 448.0), Vec2.new(1120.0, 384.0), Vec2.new(1056.0, 384.0), Vec2.new(1056.0, 320.0), Vec2.new(1120.0, 320.0), Vec2.new(1120.0, 256.0), Vec2.new(1088.0, 256.0), Vec2.new(1088.0, 224.0), Vec2.new(1120.0, 224.0), Vec2.new(1120.0, 160.0), Vec2.new(864.0, 160.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(864.0, 384.0), Vec2.new(896.0, 384.0), Vec2.new(896.0, 512.0), Vec2.new(1088.0, 512.0), Vec2.new(1088.0, 480.0), Vec2.new(1120.0, 480.0), Vec2.new(1120.0, 544.0), Vec2.new(864.0, 544.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(1024.0, 736.0), Vec2.new(1024.0, 800.0), Vec2.new(1056.0, 800.0), Vec2.new(1056.0, 832.0), Vec2.new(1120.0, 832.0), Vec2.new(1120.0, 800.0), Vec2.new(1152.0, 800.0), Vec2.new(1152.0, 736.0), Vec2.new(1120.0, 736.0), Vec2.new(1120.0, 704.0), Vec2.new(1056.0, 704.0), Vec2.new(1056.0, 736.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(608.0, 640.0), Vec2.new(672.0, 640.0), Vec2.new(672.0, 704.0), Vec2.new(704.0, 704.0), Vec2.new(704.0, 736.0), Vec2.new(832.0, 736.0), Vec2.new(832.0, 832.0), Vec2.new(800.0, 832.0), Vec2.new(800.0, 768.0), Vec2.new(640.0, 768.0), Vec2.new(640.0, 672.0), Vec2.new(608.0, 672.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(832.0, 864.0), Vec2.new(832.0, 896.0), Vec2.new(704.0, 896.0), Vec2.new(704.0, 960.0), Vec2.new(512.0, 960.0), Vec2.new(512.0, 896.0), Vec2.new(544.0, 896.0), Vec2.new(544.0, 928.0), Vec2.new(672.0, 928.0), Vec2.new(672.0, 864.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(576.0, 640.0), Vec2.new(576.0, 672.0), Vec2.new(544.0, 672.0), Vec2.new(544.0, 864.0), Vec2.new(512.0, 864.0), Vec2.new(512.0, 640.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(224.0, 800.0), Vec2.new(128.0, 800.0), Vec2.new(128.0, 768.0), Vec2.new(96.0, 768.0), Vec2.new(96.0, 736.0), Vec2.new(64.0, 736.0), Vec2.new(64.0, 576.0), Vec2.new(160.0, 576.0), Vec2.new(160.0, 608.0), Vec2.new(192.0, 608.0), Vec2.new(192.0, 672.0), Vec2.new(224.0, 672.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(96.0, 160.0), Vec2.new(96.0, 128.0), Vec2.new(32.0, 128.0), Vec2.new(32.0, 256.0), Vec2.new(64.0, 256.0), Vec2.new(64.0, 160.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(128.0, 128.0), Vec2.new(160.0, 128.0), Vec2.new(160.0, 256.0), Vec2.new(128.0, 256.0)}, Color.new(255, 241, 232, 0))
	
	--boxes
	ClosedPolylineCollider:new({Vec2.new(0.0, 0.0), Vec2.new(0.0, 32.0), Vec2.new(32.0, 32.0), Vec2.new(32.0, 0.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(192.0, 32.0), Vec2.new(192.0, 64.0), Vec2.new(224.0, 64.0), Vec2.new(224.0, 32.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(224.0, 64.0), Vec2.new(224.0, 96.0), Vec2.new(256.0, 96.0), Vec2.new(256.0, 64.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(448.0, 160.0), Vec2.new(480.0, 160.0), Vec2.new(480.0, 96.0), Vec2.new(512.0, 96.0), Vec2.new(512.0, 64.0), Vec2.new(448.0, 64.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(800.0, 0.0), Vec2.new(800.0, 96.0), Vec2.new(832.0, 96.0), Vec2.new(832.0, 64.0), Vec2.new(864.0, 64.0), Vec2.new(864.0, 0.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(1184.0, 320.0), Vec2.new(1184.0, 384.0), Vec2.new(1248.0, 384.0), Vec2.new(1248.0, 352.0), Vec2.new(1216.0, 352.0), Vec2.new(1216.0, 320.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(864.0, 640.0), Vec2.new(864.0, 672.0), Vec2.new(896.0, 672.0), Vec2.new(896.0, 704.0), Vec2.new(960.0, 704.0), Vec2.new(960.0, 672.0), Vec2.new(928.0, 672.0), Vec2.new(928.0, 640.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(928.0, 928.0), Vec2.new(928.0, 960.0), Vec2.new(1024.0, 960.0), Vec2.new(1024.0, 928.0), Vec2.new(1056.0, 928.0), Vec2.new(1056.0, 896.0), Vec2.new(960.0, 896.0), Vec2.new(960.0, 928.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(0.0, 800.0), Vec2.new(0.0, 864.0), Vec2.new(32.0, 864.0), Vec2.new(32.0, 800.0)}, Color.new(255, 241, 232, 0))
	ClosedPolylineCollider:new({Vec2.new(448.0, 480.0), Vec2.new(448.0, 544.0), Vec2.new(544.0, 544.0), Vec2.new(544.0, 512.0), Vec2.new(512.0, 512.0), Vec2.new(512.0, 448.0), Vec2.new(480.0, 448.0), Vec2.new(480.0, 480.0)}, Color.new(255, 241, 232, 0))
	
	LineCollider:new(Vec2.new(-32.0, 32.0), Vec2.new(-32.0, 320.0), Color.new(255, 241, 9, 0))
	LineCollider:new(Vec2.new(-32.0, 384.0), Vec2.new(-32.0, 928.0), Color.new(255, 241, 232, 0))
	
	localPlayer = Player:new(352, 352)
	cameraFollow(localPlayer)

	Tramway:new(Vec2.new(-145, 350), "Let`s kill here all")
	TaskBase:new("kill: ", "Common spider", 5)
end

function ArcadeLevel0:additionalUpdate()
	-- WORLD CHANGING
	--rectangleObject:rotateToBy(2, rectangleObject.angle)
	if(isCreative) then
		cameraFollow(localPlayer)
	else
		cameraEaseBoxedFollow(localPlayer)
	end
end

function ArcadeLevel0:additionalDraw()
end