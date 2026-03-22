function loadData()
	return {
		game = loadGameData(),
		collider = loadColliderData(),
		entity = loadEntityData(),
		gui = loadGUIData(),
		item = loadItemData(),
		environment = loadEnvironmentData(),
		other = loadOtherData()
	}
end

function loadGameData()
	return {
		title = "Milky way",
		cursorSpriteDir = "Content/Sprites/Cursor.img",
		tileSize = 32,
		levels = loadLevelsData(),
		blocks = {grass = 0, path = 1, dirt = 2, box = 3, concrete = 4},
		randomizingBlocks = {0, 8, 16, 32, 48},
		randomizingBlocksCountInARow = {6, 2, 2, 2, 8},
		AutoBlocks = {88, 112},
		AutoBlocksIndexes = {LUWall = -7, UWall = -6, RUWall = -5, UThinWall = -4, LThinWall = -3,  HThinWall = -2, RThinWall = -1,
							 LWall = 1,   MWall = 2,  RWall = 3,   VThinWall = 4,  LUThinWall = 5,  RUThinWall = 6, MThinWall = 7,
							 LDWall = 8,  DWall = 9,  RDWall = 10, DThinWall = 11, LDThinWall = 12, RDThinWall = 13}
	}
end

function loadLevelsData()
	return {
		story = loadStoryLevelsData(),
		arcade = loadArcadeLevelsData(),
		test = loadTestLevelsData()
	}
end

function loadStoryLevelsData()
	return {
		start = {
			class = "Scene",
			name = "Start",
			scene = StoryLevel0
		}
	}
end

function loadArcadeLevelsData()
	return {
		level0 = {
			class = "Scene",
			name = "level0",
			scene = ArcadeLevel0
		}
	}
end

function loadTestLevelsData()
	return {
		main = {
			class = "Scene",
			name = "Main",
			scene = TestScene
		}
	}
end

function loadColliderData()
	return {
		closedPolylineCollider = {
			class = "Collider",
			name = "Closed polyline collider"
		},
		polylineCollider = {
			class = "Collider",
			name = "Polyline collider"
		},
		lineCollider = {
			class = "Collider",
			name = "Line collider"
		},
		quadCollider = {
			class = "Collider",
			name = "Quad collider"
		},
		rectangleCollider = {
			class = "Collider",
			name = "Rectangle collider"
		}
	}
end

function loadGUIData()
	return {
		charSize = 8,
		fontSize = 15,
		button = {
			class = "GUI",
			name = "Button",
			border = 10
		},
		counter = {
			class = "GUI",
			name = "Counter"
		},
		scale = {
			class = "GUI",
			name = "Scale"
		},
		textBox = {
			class = "GUI",
			name = "Text box",
			border = 10
		}
	}
end

function loadItemData()
	return {
		unknown = {
			class = "Item",
			name = "Unknown",
			spriteDir = "Content/Sprites/Items/Unknown_item.img",
			size = 12,
			defaultStack = 1
		},
		ammo = {
			class = "Item",
			name = "Ammo",
			spriteDir = "Content/Sprites/Items/Ammo.img",
			size = 10,
			defaultStack = 30
		},
		gear = {
			class = "Item",
			name = "Gear",
			spriteDir = "Content/Sprites/Items/Gear.img",
			size = 16,
			defaultStack = 1
		},
		medicine = {
			class = "Item",
			name = "Medicine",
			spriteDir = "Content/Sprites/Items/Medicine.img",
			size = 12,
			defaultStack = 1,
			healSize = 20
		},
		sound = {
			pickup = Resources.load("Content/Sounds/Items/selection.wav", Sfx)
		}
	}
end

function loadEntityData()
	return {
		enemy = {
			spider = loadSpiderData(),
			commonSpider = loadCommonSpiderData(),
			gobberSpider = loadGobberSpiderData()
		},
		projectile = {
			bullet = loadBulletData(),
			cobwebShell = loadCobwebsShellData()
		},
		other =  {
			player = loadPlayerData()
		},
		sound = {
			grassWalk = {
				Resources.load("Content/Sounds/Entities/Grass_hit1.ogg", Sfx),
				Resources.load("Content/Sounds/Entities/Grass_hit2.ogg", Sfx),
				Resources.load("Content/Sounds/Entities/Grass_hit3.ogg", Sfx),
				Resources.load("Content/Sounds/Entities/Grass_hit4.ogg", Sfx),
				Resources.load("Content/Sounds/Entities/Grass_hit5.ogg", Sfx),
				Resources.load("Content/Sounds/Entities/Grass_hit6.ogg", Sfx)
			}
		}
	}
end

function loadSpiderData()
	return {
		sizeModifier = 2,
		waitingTime = 5 * 60,
		patrolDelay = 2 * 60,
		strayRadius = 100,
		strayDelay = 2 * 60
	}
end

function loadCommonSpiderData()
	return {
		class = "Entity",
		entityType = "Enemy",
		name = "Common spider",
		spriteDir = "Content/Sprites/Entities/Spider.spr",
		color = Color.new(100, 70, 50, 255),
		health =  100,
		speed = 2.1,
		size = 10,
		hitDistance = 20,
		hitDamage = 20,
		hitCd = 1 * 60,
		visionDistance = 250,
		visionAngle = math.rad(120),
		flairDistance = 150
	}
end

function loadGobberSpiderData()
	return {
		class = "Entity",
		entityType = "Enemy",
		name = "Gobber spider",
		spriteDir = "Content/Sprites/Entities/Spider.spr",
		color = Color.new(30, 30, 30, 255),
		health =  70,
		speed = 1.5,
		size = 7,
		hitDistance = 200,
		hitDamage = 30,
		hitCd = 2 * 60,
		visionDistance = 300,
		visionAngle = math.rad(120),
		flairDistance = 100
	}
end

function loadBulletData()
	return {
		class = "Entity",
		entityType = "Projectile",
		name = "Bullet",
		health = 25,
		speed = 5,
		size = 1,
		hitDamage = 25,
		color = Color.new(228, 170, 100)
	}
end

function loadCobwebsShellData()
	return {
		class = "Entity",
		entityType = "Projectile",
		name = "Cobweb shell",
		health = 10,
		speed = 4,
		size = 3,
		hitDamage = 25,
		color = Color.new(255, 255, 255)
	}
end

function loadPlayerData()
	return {
		class = "Entity",
		entityType =  "Other",
		name = "Player",
		spriteDir = "Content/Sprites/Entities/Player.spr",
		shootSoundDir = "Content/Sounds/Entities/Player/shoot.wav",
		health = 100,
		speed = 2,
		boost = 1.5,
		sprintReloadTime = 2 * 60,
		size = 6,
		sizeModifier = 2,
		hitDistance = 20,
		hitDamage = 10,
		hitCd = 1 * 60 -- NEED TO BE IN THE GAME (MAYBE)
	}
end

function loadEnvironmentData()
	return {
		shader = loadShaderData(),
		environment = {
			class = "Environment",
			name = "Environment",
			defaultColor = Color.new(77, 3, 0, 20),--Color.new(227, 102, 214, 20),
			defaultTime = 12000,
			timeInDay = 24000
		}
	}
end

function loadShaderData()
	return {
		tileShader = {
			class = "Shader",
			name = "Tile Shader"
		}
	}
end

function loadOtherData()
	return {
		spawner = {
			class = "Other",
			name = "Spawner",
			size = 16,
			defaultCooldown = 5 * 60
		},
		itemSpawner = {
			class = "Spawner",
			name = "Item spawner",
			size = 16,
			defaultCooldown = 5 * 60
		},
		spiderSpawner = {
			class = "Spawner",
			name = "Spider spawner",
			spriteDir = "Content/Sprites/Entities/SpiderSpawner.spr",
			size = 48,
			defaultCooldown = 5 * 60,
			defaultPosition = Vec2.new(0, 0)
		},
		task =  {
			class = "Other",
			name = "Task",
			position = Vec2.new(300, -150),
			offset = 5
		},
		tramway =  {
			class = "Other",
			name = "Tramway",
			spriteDir = "Content/Sprites/Entities/Tramway.img",
			usageRadius = 100,
			defaultMessage = "At first I need to do some tasks",
			noStopsMessage = "It have no more stops"
		},
		camera = {
			speed = 0.02,
			boxRadius = 10
		},
		coroutine = {
			delayedCoroutine = {
				class = "Coroutine",
				name = "Delayed coroutine"
			}
		},
		point = {
			class = "Other",
			name = "Point"
		}
	}
end