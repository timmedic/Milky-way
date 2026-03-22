require("Scenes/Scene_base.lua")

TestScene = Scene:new()

function TestScene:loadResources()
	--PixelShader:new()
	TileShader:new()
	
	self.levelMap = Resources.load("mapn.map")
	self.levelMap_l2 = Resources.load("map_l2.map")
	DelayedCoroutine.new(nil, coroutine.create(corRadndomizeSpecTiles), self.levelMap)
	
	
	--ItemSpawner:new({Vec2.new(200, 350)}, Ammo:new())
	--ItemSpawner:new({Vec2.new(500, 350)}, Medicine:new())
	--Gear:new(600, 350)
	--ItemSpawner:new({Vec2.new(600, 350)}, Gear:new(), 60)
	
	ItemSpawner:new({Vec2.new(992.0, 352.0), Vec2.new(608.0, 896.0), Vec2.new(-64.0, 608.0)}, Ammo:new())
	ItemSpawner:new({Vec2.new(96.0, 832.0), Vec2.new(544.0, 480.0), Vec2.new(608.0, 128.0), Vec2.new(160.0, 64.0)}, Ammo:new())
	ItemSpawner:new({Vec2.new(96.0, 192.0), Vec2.new(992.0, 224.0), Vec2.new(736.0, 800.0)}, Medicine:new())
	CommonSpiderSpawner:new({Vec2.new(608.0, 800.0), Vec2.new(128.0, 512.0), Vec2.new(544.0, 192.0)}, nil, DATA.entity.enemy.commonSpider)

	--[[QuadCollider:new(Vec2.new(100, 100), Vec2.new(240, 100), Vec2.new(300, 300), Vec2.new(100, 240), Color.new(174, 114, 252), true, true)
	QuadCollider:new(Vec2.new(460, 100), Vec2.new(600, 100), Vec2.new(600, 240), Vec2.new(400, 300), Color.new(174, 114, 252), true, true)
	QuadCollider:new( Vec2.new(300.0, 400.0), Vec2.new(240.0, 600.0), Vec2.new(100.0, 600.0), Vec2.new(100.0, 460.0), Color.new(174, 114, 252), true, true)
	QuadCollider:new( Vec2.new(400.0, 400.0), Vec2.new(600.0, 460.0), Vec2.new(600, 600.0), Vec2.new(460, 600.0), Color.new(174, 114, 252), true, true)

	QuadCollider:new( Vec2.new(660.0, 100.0), Vec2.new(720.0, 100.0), Vec2.new(720.0, 300.0), Vec2.new(660.0, 300.0), Color.new(0, 192, 255, 255), true, true)
	QuadCollider:new( Vec2.new(660.0, 600.0), Vec2.new(720.0, 600.0), Vec2.new(720.0, 400.0), Vec2.new(660.0, 400.0), Color.new(0, 192, 255, 255), true, true)
	QuadCollider:new( Vec2.new(720.0, 100.0), Vec2.new(920.0, 100.0), Vec2.new(920.0, 160.0), Vec2.new(720.0, 160.0), Color.new(0, 192, 255, 255), true, true)
	QuadCollider:new( Vec2.new(720.0, 600.0), Vec2.new(920.0, 600.0), Vec2.new(920.0, 540.0), Vec2.new(720.0, 540.0), Color.new(0, 192, 255, 255), true, true)
	QuadCollider:new( Vec2.new(920.0, 160.0), Vec2.new(860.0, 160.0), Vec2.new(860.0, 540.0), Vec2.new(920.0, 540.0), Color.new(0, 192, 255, 255), true, true)
	QuadCollider:new( Vec2.new(760.0, 200.0), Vec2.new(820.0, 200.0), Vec2.new(820.0, 500.0), Vec2.new(760.0, 500.0), Color.new(0, 192, 255, 255), true, true)

	QuadCollider:new( Vec2.new(864.0, 384.0), Vec2.new(896.0, 384.0), Vec2.new(896.0, 544.0), Vec2.new(864.0, 544.0), Color.new(255, 255, 255), true, false)
	QuadCollider:new( Vec2.new(896.0, 512.0), Vec2.new(1056.0, 512.0), Vec2.new(1056.0, 544.0), Vec2.new(896.0, 544.0), Color.new(255, 255, 255), true, false)
	QuadCollider:new( Vec2.new(896.0, 320.0), Vec2.new(864.0, 320.0), Vec2.new(864.0, 160.0), Vec2.new(896.0, 160.0), Color.new(255, 255, 255), true, false)
	QuadCollider:new( Vec2.new(896.0, 160.0), Vec2.new(1056.0, 160.0), Vec2.new(1056.0, 192.0), Vec2.new(896.0, 192.0), Color.new(255, 255, 255), true, false)
	QuadCollider:new( Vec2.new(1024.0, 192.0), Vec2.new(1056.0, 192.0), Vec2.new(1056.0, 512.0), Vec2.new(1024.0, 512.0), Color.new(255, 255, 255), true, false)
	
	QuadCollider:new( Vec2.new(-96, 0), Vec2.new(canvasWidth*2-1, 0), Vec2.new(canvasWidth*2-1, canvasHeight*2-1), Vec2.new(-96, canvasHeight*2-1), Color.new(255, 255, 255, 255), false, false)
	]]--
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


	--Spawner:new(25, 25, spider)
	
	--quadCollider:new(Vec2.new(200, 200), Vec2.new(280, 150), Vec2.new(300, 300), Vec2.new(170, 250), true, Color.new(255, 200, 100, 255))
	--rectangleObject = RectangleCollider:new(Vec2.new(350, 350), Vec2.new(0, 0), Vec2.new(100, 40), math.rad(45), true, Color.new(255, 200, 100, 255))
	
	l1Button = Button:new(Vec2.new(0.4, 0.4), "l1")
	function l1Button:onClick()
		require("Scenes/level1.lua")
		level1:setScene()
	end
	
	testTrigger = Trigger:new(Vec2.new(100, 100), 100, true)
	function testTrigger:doAction()
		TextBox:new(Vec2.new(0, 0.35), "I got no time to explore it, at first I need to find the way to get out", 7*60)
	end
	
	--SpiderSpawner:new({Vec2.new(25, 25), Vec2.new(175, 25), Vec2.new(325, 25)})
	--SpiderSpawner:new({Vec2.new(25, 295), Vec2.new(175, 295), Vec2.new(325, 295), Vec2.new(25, 175)}, 4 * 60)
	--Spider:new(175, 25, false, true, {Vec2.new(175, 25), Vec2.new(200, 40), Vec2.new(150, 40)})
	--SpiderSpawner:new({Vec2.new(25, 25), Vec2.new(175, 25), Vec2.new(325, 25)}, nil, DATA.entity.enemy.commonSpider)
	--spider = CommonSpider:new(canvasWidth / 2, 50)
	--GobberSpider:new(100, 100)
	localPlayer = Player:new(352, 352)
	cameraFollow(localPlayer)

	Tramway:new(Vec2.new(-145, 350), "I think I can find some parts in this village to repair it")

	TaskBase:new("collect", "Gear", 5)
end

function TestScene:additionalUpdate()
	-- WORLD CHANGING
	--rectangleObject:rotateToBy(2, rectangleObject.angle)
	if(isCreative) then
		cameraFollow(localPlayer)
	else
		cameraEaseBoxedFollow(localPlayer)
	end
end

function TestScene:additionalDraw()
end