require("Object.lua")
TileShader = {}

function TileShader:new()
	
	obj = Object:new(false, true, DATA.environment.shader.tileShader)
	
	function obj:draw()
		local shadeColor = Color.new(50, 50, 50)
		local density = 255
		local zeros = Vec2.new(cameraPosition.x - canvasWidth/2, cameraPosition.y - canvasHeight/2)
		for y = zeros.y, zeros.y + canvasHeight, 33 do
			for x = zeros.x, zeros.x + canvasWidth, 33 do
				local alpha = cameraPosition:distanceTo(Vec2.new(x,y)) / cameraPosition:distanceTo(zeros) * density
				rect(x, y, x+32, y+32, true, Color.new(shadeColor.r, shadeColor.g, shadeColor.b, alpha))
			end
		end
	end
	
	table.insert(currentScene.environment, obj)
	return obj
end