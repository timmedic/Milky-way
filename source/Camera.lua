cameraPosition = Vec2.new(0, 0)

function cameraFollow(target)
	if(target) then
		camera(target.position.x - canvasWidth / 2, target.position.y - canvasHeight / 2)
		cameraPosition = Vec2.new(target.position.x, target.position.y)
	else
		print("Error: no target")
	end
end

function cameraEaseBoxedFollow(target)
	if(target and target.position) then
		if(cameraPosition:distanceTo(target.position) > DATA.other.camera.boxRadius) then
			local newPosition = cameraPosition + ((target.position - cameraPosition) * DATA.other.camera.speed)
			camera(newPosition.x - canvasWidth / 2, newPosition.y - canvasHeight / 2)
			cameraPosition = Vec2.new(newPosition.x, newPosition.y)
		end
	else
		print("Error: no target")
	end
end

function cameraSetPosition(position)
	camera(position.x - canvasWidth / 2, position.y - canvasHeight / 2)
	cameraPosition = Vec2.new(position.x, position.y)
end