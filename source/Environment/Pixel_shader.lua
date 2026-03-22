require("Object.lua")
PixelShader = {}

function PixelShader:new()
	local shadeImage = Image.new()
	for y = 0, 255 do
		for x = 0, 255 do
			shadeImage:set(x, y, Color.new(255, 100, 100, 100))
		end
	end
	
	obj = Object:new(false, true)
	obj.texture = Resources.load(shadeImage, Texture)
	
	function obj:draw()
		local shadeColor = Color.new(50, 50, 50)
		local density = 255
		local zeros = Vec2.new(cameraPosition.x - canvasWidth/2, cameraPosition.y - canvasHeight/2)
		tex(self.texture(), 0, 0, 100, 100)
	end
	
	table.insert(currentScene.environment, obj)
	return obj
end