require("Camera.lua")
require("Keyboard.lua")
require("Keycode.lua")
require("Mouse.lua")
require("Better_shapes.lua")

require("Environment/Tile_shader.lua")
require("Environment/Pixel_shader.lua")
require("Environment/Environment.lua")

require("Scenes/Test_scene.lua")
require("Scenes/Main_menu.lua")
require("Scenes/Story/level0.lua")
require("Scenes/Arcade/level0.lua")
require("Scenes/mapUpdateTest.lua")

require("Colliders/Quad_collider")
require("Colliders/Rectangle_collider")
require("Colliders/Line_collider.lua")
require("Colliders/Polyline_collider")
require("Colliders/Closed_polyline_collider")

require("Entities/Tramway.lua")

require("Entities/Entity.lua")
require("Entities/Enemy.lua")
require("Entities/Player.lua")
require("Entities/Spider_base.lua")
require("Entities/Common_spider.lua")
require("Entities/Gobber_spider.lua")
require("Entities/Bull.lua")

require("Spawner.lua")

require("Items/Item.lua")

require("GUI/Scale")
require("GUI/Counter")
require("GUI/Text_box")
require("GUI/Button")

require("Tasks/Task_base")

require("Trigger.lua")

require ('Point')
require("Coroutines.lua")
require("Gamemode_creative.lua")
require("Data_utils.lua")
require("Map_utils.lua")
require("Loading_screen")

local developer_mode = true
debugMode = false
isCreative = false
renderEdges = false
serealizedData = {}
currentLevel = 1
gamemodes = {arcade = 0, story = 1, test = 2}
gamemode = gamemodes.test -- Then will be changing by main menu
localPlayer = nil
local cursorSprite = nil
DATA = nil

function setup()
	mouseX, mouseY = 0, 0
	rand = Random.new(DateTime.ticks())
	canvasWidth, canvasHeight = Canvas.main:size()
	Canvas.main:resize(900, 500)
	canvasWidth, canvasHeight = Canvas.main:size()
	DATA = loadData()
	cursorSprite = Resources.load(DATA.game.cursorSpriteDir)
	Application.setCursor("none")
	
	--TestScene:setScene()
	MainMenu:setScene()
	--MapUpdateTest:setScene()
end

function GetInput()
	mX, mY, lmb, rmb = mouse()
	mouseLeftClicked = isMouseLeftClicked()
	mouseRightClicked = isMouseRightClicked()
	if(mX >= -1000000) then
		mouseX = mX + cameraPosition.x - canvasWidth / 2
		mouseY = mY + cameraPosition.y - canvasHeight / 2
	end
	if(keyp(KeyCode.P)) then exit() end
end

function update(delta)
	playerInput = GetInput()
	if(currentScene and currentScene.loaded and currentScene.update and currentScene.draw) then
		currentScene:update()
		currentScene:draw()
	end
	tex(cursorSprite, mouseX - cursorSprite.width/2, mouseY - cursorSprite.height/2, cursorSprite.width, cursorSprite.height)

	buildHandle()
end