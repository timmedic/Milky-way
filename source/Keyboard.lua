downedKeys = {}

function keyClicked(code)
	if key(code) and not downedKeys[code] then
		downedKeys[code] = true
		return false
	elseif not key(code) and downedKeys[code] then
		downedKeys[code] = false
		return true
	end
	return false
end