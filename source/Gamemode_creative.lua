require("Mouse.lua")

local autoCorrect = 32
local buildPoints = {}
local pal = Resources.load("Pallete.pal")
local changedColor = 7
local PALLETE_SIZE = 255
local palleteActive = false
buildModes = {"Closed polyline", "Quad", "Rectangle", "Polyline", "Line", "Medicine spawner", "Ammo spawner", "Spider spawner"} -- "Tile"
buildMode = 1

function drawPallete()
	local palPos = cameraPosition + Vec2.new(140, -220)
	if(palleteActive) then
		for i = 0, PALLETE_SIZE do
			local row = (i // 16) * 10
			local column = (i % 16) * 10
			rect(palPos.x + column, palPos.y + row, palPos.x + column + 9, palPos.y + row + 9, true, pget(pal, i))
			if(i == changedColor) then
				local c = math.abs(math.sin(DateTime.toSeconds(DateTime.ticks()))) * 255
				rect(palPos.x + column, palPos.y + row, palPos.x + column + 9, palPos.y + row + 9, false, Color.new(c, c, c))
			end
		end
	end
end

function roundForStep(x, step)
	local toFloor = (x - (x % step))
	local toCeil = (x + (step - (x % step)))
	if(math.abs(x - toFloor) <= math.abs(x - toCeil)) then
		return toFloor
	else
		return toCeil
	end
end

function buildClosedPolyline(points)
	local col = pget(pal, changedColor)
	
	if(changedColor == 0) then
		ClosedPolylineCollider:new(points, Color.new(255, 255, 255, 255))
	else
		ClosedPolylineCollider:new(points, col)
	end
	
	local sPoints = ""
	for i = 1, #points do
		if(i ~= 1) then sPoints = sPoints..", " end
		sPoints = sPoints.."Vec2.new(".. points[i].x ..", ".. points[i].y ..")"
	end
	print("ClosedPolylineCollider:new({".. sPoints .."}, Color.new("..col.r..", "..col.g..", "..col.b..", "..col.a.."))")
end
function buildQuad(point1, point2, point3, point4)
	local col = pget(pal, changedColor)
	local visible = true
	local sVisible = "true"
	if(changedColor == 0) then col = Color.new(255, 255, 255); visible = false; sVisible = "false" end
	QuadCollider:new(point1, point2, point3, point4, col, visible, true)
	print("QuadCollider:new( Vec2.new(" .. point1.x .. ", " .. point1.y .."), Vec2.new(" .. point2.x .. ", " .. point2.y .."), Vec2.new(" .. point3.x .. ", " .. point3.y .."), Vec2.new(" .. point4.x .. ", " .. point4.y .."), Color.new("..col.r..", "..col.g..", "..col.b.."), true, "..sVisible..")")
end
function buildRectangle(point1, point2)
	local center = (point1 + point2) * 0.5
	local size = Vec2.new(math.abs(point1.x - point2.x), math.abs(point1.y - point2.y))
	local col = pget(pal, changedColor)
	RectangleCollider:new(center, Vec2.new(0, 0), size, math.rad(0), true, col)
	print("RectangleCollider:new(Vec2.new("..center.x..", "..center.y.."), Vec2.new(0, 0), Vec2.new("..size.x..", "..size.y.."), math.rad(0), true, Color.new("..col.r..", "..col.g..", "..col.b.."))")
end
function buildPolyline(points)
	local col = pget(pal, changedColor)
	
	if(changedColor == 0) then
		PolylineCollider:new(points, Color.new(255, 255, 255, 255))
	else
		PolylineCollider:new(points, col)
	end
	
	local sPoints = ""
	for i = 1, #points do
		if(i ~= 1) then sPoints = sPoints..", " end
		sPoints = sPoints.."Vec2.new(".. points[i].x ..", ".. points[i].y ..")"
	end
	print("PolylineCollider:new({".. sPoints .."}, Color.new("..col.r..", "..col.g..", "..col.b..", "..col.a.."))")
end
function buildLine(point1, point2)
	local col = pget(pal, changedColor)
	LineCollider:new(point1, point2, col)
	print("LineCollider:new(Vec2.new("..point1.x..", "..point1.y.."), Vec2.new("..point2.x..", "..point2.y.."), Color.new("..col.r..", "..col.g..", "..col.b.."))")
end
function buildMedicineSpawner(point)
	ItemSpawner:new({Vec2.new(point.x, point.y)}, Medicine:new())
	print("ItemSpawner:new({Vec2.new("..point.x..", "..point.y..")}, Medicine:new())")
end
function buildAmmoSpawner(point)
	ItemSpawner:new({Vec2.new(point.x, point.y)}, Ammo:new())
	print("ItemSpawner:new({Vec2.new("..point.x..", "..point.y..")}, Ammo:new())")
end
function buildSpiderSpawner(point)
	SpiderSpawner:new({point}, nil, DATA.entity.enemy.commonSpider)
	print("SpiderSpawner:new({Vec2.new("..point.x..", "..point.y..")}, nil, DATA.entity.enemy.commonSpider)")
end

function buildHandle()
	if(keyClicked(KeyCode.C)) then
		isCreative = not isCreative
		TextBox:new(Vec2.new(0, 0.35), "creative mode changed", 2*60)
	end
	
	if(isCreative) then
		--doOnMouseLeftClickedInBoxOnScreen(Vec2.new(palPos.x + -25, palPos.y), Vec2.new(palPos.x - 5, palPos.y + 20))
		drawPallete()
		text(math.floor(mouseX) .. " " .. math.floor(mouseY), cameraPosition.x - 300, cameraPosition.y - 200)
		text("tool:".. buildModes[buildMode], cameraPosition.x - 300, cameraPosition.y + 160)
		text("auto correct: ".. autoCorrect, cameraPosition.x - 300, cameraPosition.y + 180)
		local mouseFixedX = roundForStep(mouseX, autoCorrect)
		local mouseFixedY = roundForStep(mouseY, autoCorrect)
		line(mouseFixedX, mouseFixedY - 10, mouseFixedX, mouseFixedY + 10)
		line(mouseFixedX - 10, mouseFixedY, mouseFixedX + 10, mouseFixedY)
		if(#buildPoints > 0) then
			if(buildModes[buildMode] == "Closed polyline" or buildModes[buildMode] == "Quad" or buildModes[buildMode] == "Polyline" or buildModes[buildMode] == "Line") then
				if(#buildPoints > 1) then
					for i = 1, #buildPoints - 1 do
						line(buildPoints[i].x, buildPoints[i].y, buildPoints[i + 1].x, buildPoints[i + 1].y)
					end
				end
				line(buildPoints[#buildPoints].x, buildPoints[#buildPoints].y, mouseFixedX, mouseFixedY)
			elseif( buildModes[buildMode] == "Rectangle" ) then
				line(buildPoints[1].x, buildPoints[1].y, mouseFixedX, buildPoints[1].y)
				line(buildPoints[1].x, buildPoints[1].y, buildPoints[1].x, mouseFixedY)
				line(mouseFixedX, buildPoints[1].y, mouseFixedX, mouseFixedY)
				line(buildPoints[1].x, mouseFixedY, mouseFixedX, mouseFixedY)
			end
			
			
			local posChangesX = ((mouseFixedX - buildPoints[#buildPoints].x))
			local posChangesY = ((mouseFixedY - buildPoints[#buildPoints].y))
			text("[" .. posChangesX .. ", " .. posChangesY .. "]", mouseX, mouseY - 20)
		end
	
		if(mouseLeftClicked) then
			table.insert(buildPoints, Vec2.new(mouseFixedX, mouseFixedY))
			
			if(currentScene.levelMap and buildModes[buildMode] == "Tile" and #buildPoints >= 1) then
				local current = mget(currentScene.levelMap, mouseFixedX/DATA.game.tileSize+currentScene.levelMap.width/2, mouseFixedY/DATA.game.tileSize+currentScene.levelMap.height/2)
				if(current == DATA.game.blocks.BOX) then
					mset(currentScene.levelMap, mouseFixedX/DATA.game.tileSize+currentScene.levelMap.width/2, mouseFixedY/DATA.game.tileSize+currentScene.levelMap.height/2, DATA.game.blocks.GRASS)
				else
					mset(currentScene.levelMap, mouseFixedX/DATA.game.tileSize+currentScene.levelMap.width/2, mouseFixedY/DATA.game.tileSize+currentScene.levelMap.height/2, DATA.game.blocks.BOX)
				end
				buildPoints = {}
			elseif(buildModes[buildMode] == "Closed polyline" and #buildPoints >= 2 and buildPoints[#buildPoints] == buildPoints[1]) then
				table.remove(buildPoints)
				buildClosedPolyline(buildPoints)
				buildPoints = {}
			elseif(buildModes[buildMode] == "Quad" and #buildPoints >= 4) then
				buildQuad(buildPoints[1], buildPoints[2], buildPoints[3], buildPoints[4])
				buildPoints = {}
			elseif(buildModes[buildMode] == "Rectangle" and #buildPoints >= 2) then
				buildRectangle(buildPoints[1], buildPoints[2])
				buildPoints = {}
			elseif(buildModes[buildMode] == "Polyline" and #buildPoints >= 2 and buildPoints[#buildPoints] == buildPoints[1]) then
				table.remove(buildPoints)
				buildPolyline(buildPoints)
				buildPoints = {}
			elseif(buildModes[buildMode] == "Line" and #buildPoints >= 2) then
				buildLine(buildPoints[1], buildPoints[2])
				buildPoints = {}
			elseif(buildModes[buildMode] == "Medicine spawner" and #buildPoints >= 1) then
				buildMedicineSpawner(buildPoints[1])
				buildPoints = {}
			elseif(buildModes[buildMode] == "Ammo spawner" and #buildPoints >= 1) then
				buildAmmoSpawner(buildPoints[1])
				buildPoints = {}
			elseif(buildModes[buildMode] == "Spider spawner" and #buildPoints >= 1) then
				buildSpiderSpawner(buildPoints[1])
				buildPoints = {}
			end
		elseif(mouseRightClicked) then
			buildMode = (buildMode % #buildModes) + 1
			buildPoints = {}
		elseif(keyp(KeyCode.Z)) then
			buildPoints = {}
		elseif(keyp(KeyCode.O)) then
			palleteActive = not palleteActive
		elseif not(palleteActive) then
			if(keyp(KeyCode.Down) and autoCorrect > 1) then
				autoCorrect = autoCorrect - 1
			elseif(keyp(KeyCode.Up) and autoCorrect < 50) then
				autoCorrect = autoCorrect + 1
			elseif(keyp(KeyCode.Left)) then
				buildMode = buildMode - 1
				if(buildMode == 0) then buildMode = #buildModes end
				buildPoints = {}
			elseif(keyp(KeyCode.Right)) then
				buildMode = (buildMode % #buildModes) + 1
				buildPoints = {}
			end
		elseif(palleteActive) then
			if(keyp(KeyCode.Down)) then
				changedColor = (changedColor + 16) % (PALLETE_SIZE + 1)
			elseif(keyp(KeyCode.Up)) then
				changedColor = (changedColor - 16) % (PALLETE_SIZE + 1)
			elseif(keyp(KeyCode.Left)) then
				changedColor = (changedColor - 1) % (PALLETE_SIZE + 1)
			elseif(keyp(KeyCode.Right)) then
				changedColor = (changedColor + 1) % (PALLETE_SIZE + 1)
			end
			
			if(changedColor < 0) then
				changedColor = changedColor + PALLETE_SIZE - 1
			end
		end
	end
end