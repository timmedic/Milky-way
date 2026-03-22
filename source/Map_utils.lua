MapUtil = {}

function MapUtil:new(mapRes)
	
	obj = Object:new(false, false)
	obj.mapRes = mapRes
	
	function obj:drawSquare()
		
	end
	
	function obj:drawTree()
		
	end
	
	function obj:closeUtil()
		self:removeObject()
	end
	
	return obj
end

function corRadndomizeSpecTiles(mapRes)
	local randomizer = Random.new()
	randomizer:seed(39322)
	for y = 0, mapRes.height do
		for x = 0, mapRes.width do
			tryRandomizeTile(mapRes, x, y, randomizer)
		end
		if(y % 10 == 0) then
			coroutine.yield()
		end
	end
end

function radndomizeSpecTiles(mapRes)
	local randomizer = Random.new()
	randomizer:seed(39322)
	for y = 0, mapRes.height do
		for x = 0, mapRes.width do
			tryRandomizeTile(mapRes, x, y, randomizer)
		end
	end
end

function tryRandomizeTile(mapRes, x, y, randomizer)
	local currentTile = mget(mapRes, x, y)
	for i, tileNum in pairs(DATA.game.randomizingBlocks) do
		if(currentTile == tileNum) then
			mset(mapRes, x, y, randomizer:next(currentTile, currentTile + DATA.game.randomizingBlocksCountInARow[i] - 1))
		end
	end
end

function corAutomateTiles(mapRes)
	-- Bruh
	for y = 0, mapRes.height do
		for x = 0, mapRes.width do
			tryAutomateTile(mapRes, x, y)
		end
		if(y % 5 == 0) then
			coroutine.yield()
		end
	end
end

function tryAutomateTile(mapRes, x, y)
	local currentTile = mget(mapRes, x, y)
	for i, tileNum in pairs(data.autoBlocks) do
		if(currentTile == tileNum) then
			mset(mapRes, x, y, randomizer:next(0, RANDOMIZING_BLOCKS_COUNT_IN_A_ROW[i] - 1))
		end
	end
end

function setAutoTile(mapRes, x, y, tile)
	-- Not completed because it probably will freeze the game and I`m lazy
	if( not(isTileInAutoCollection(x - 1, y, tile)) ) then
		if( not(isTileInAutoCollection(x, y - 1, tile)) ) then
			mset(mapRes, x, y, tile + AUTO_BLOCKS_INDEXES.LUWall); return
		elseif( not(isTileInAutoCollection(x + 1, y, tile)) )then
			mset(mapRes, x, y, tile + AUTO_BLOCKS_INDEXES.VThinWall); return
		elseif( not(isTileInAutoCollection(x, y + 1, tile)) )then
			mset(mapRes, x, y, tile + AUTO_BLOCKS_INDEXES.LDWall); return
		end
	end
end

function isTileInAutoCollection(mapRes, x, y, tile)
	local this = mget(mapRes, x, y)
	if(this > tile + AUTO_BLOCKS_INDEXES[1] and this < tile + AUTO_BLOCKS_INDEXES[#AUTO_BLOCKS_INDEXES]) then
		return true
	end
	return false
end

function drawSquare(mapRes)
	local mapFile = File.new()
	mapFile:open("testMap.map", Stream.ReadWrite)
	local mapJson = Json.new()
	mapJson:fromBytes(mapFile:readBytes())
	local mapTable = mapJson:toTable()
	
	print(mapFile:count())
	
	mapFile:close()
end