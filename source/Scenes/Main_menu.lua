require("Scenes/Scene_base.lua")

MainMenu = Scene:new()

function MainMenu:loadResources()
	TileShader:new()
	Environment:new(true)
	
	self.levelMap = Resources.load("Levels/Main_menu.map")
	DelayedCoroutine.new(nil, coroutine.create(corRadndomizeSpecTiles), self.levelMap)
	
	cameraSetPosition(Vec2.new(0, 0))
	
	CommonSpider:new(100, 100, false, true)
	CommonSpider:new(-100, -50, false, true)
	
	TextBox:new(Vec2.new(0, -0.2), "Milky way", -1, Color.new(30, 150, 225, 100), 30)
	
	startButton = Button:new(Vec2.new(0, 0), "start", 200, 30, Color.new(100, 100, 220))
	exitButton = Button:new(Vec2.new(0, 0.1), "exit", 200, 30, Color.new(100, 100, 220))
	
	storyStartButton = Button:new(Vec2.new(0, -0.1), "Story", 200, 30, Color.new(100, 100, 220))
	storyStartButton:setActive(false)
	arcadeStartButton = Button:new(Vec2.new(0, 0), "Arcade", 200, 30, Color.new(100, 100, 220))
	arcadeStartButton:setActive(false)
	testStartButton = Button:new(Vec2.new(0, 0.1), "Test", 200, 30, Color.new(100, 100, 220))
	testStartButton:setActive(false)
	backButton = Button:new(Vec2.new(0, 0.2), "Back", 200, 30, Color.new(100, 100, 220))
	backButton:setActive(false)
	
	function startButton:onClick()
		startButton:setActive(false)
		exitButton:setActive(false)
		
		storyStartButton:setActive(true)
		arcadeStartButton:setActive(true)
		testStartButton:setActive(true)
		backButton:setActive(true)
	end
	
	function exitButton:onClick()
		exit()
	end
	
	function storyStartButton:onClick()
		gamemode = gamemodes.story
		DATA.game.levels.story.start.scene:setScene()
	end
	
	function arcadeStartButton:onClick()
		gamemode = gamemodes.arcade
		DATA.game.levels.arcade.level0.scene:setScene()
	end
	
	function testStartButton:onClick()
		gamemode = gamemodes.test
		DATA.game.levels.test.main.scene:setScene()
	end
	
	function backButton:onClick()
		storyStartButton:setActive(false)
		arcadeStartButton:setActive(false)
		testStartButton:setActive(false)
		backButton:setActive(false)
		
		startButton:setActive(true)
		exitButton:setActive(true)
	end
end