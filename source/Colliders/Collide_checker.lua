function getCollides(subject)
	local collides = {}
	
	if not subject then
		print("ERROR: no subject to get collides with")
		return collides
	end
	
	for i, subjectCollider in pairs(subject.colliders) do
	
		for j, objectType in pairs(currentScene.scene) do
		
			for g, object in pairs(objectType) do
			
				if( object ~= subject and object.colliders) then
				
					for _, objectCollider in pairs(object.colliders) do
					
						if (Math.intersects(subjectCollider, objectCollider)) then
							table.insert(collides, object)
						end
					end
				end
			end
		end
	end

	return collides
end