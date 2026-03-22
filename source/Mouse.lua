isLmbDown = false
isRmbDown = false

function isMouseLeftClicked()
	if lmb and not isLmbDown then
		isLmbDown = true
		return false
	elseif not lmb and isLmbDown then
		isLmbDown = false
		return true
	end
	return false
end

function isMouseRightClicked()
	if rmb and not isRmbDown then
		isRmbDown = true
		return false
	elseif not rmb and isRmbDown then
		isRmbDown = false
		return true
	end
	return false
end

function isMouseInBox(point1, point2)
	if(mouseX >= point1.x and mouseY >= point1.y and mouseX <= point2.x and mouseY <= point2.y) then
		return true
	end
end

function doOnMouseInBox(point1, point2, func)
	local function noFunc() print("no func to do") end
	func = func or noFunc
	if(mouseX >= point1.x and mouseY >= point1.y and mouseX <= point2.x and mouseY <= point2.y) then
		func()
	end
end

function doOnMouseLeftClickedInBoxOnScreen(point1, point2, func)
	local function noFunc() print("no func to do") end
	local func = func or noFunc
	if(mouseLeftClicked() and mouseX >= point1.x and mouseY >= point1.y and mouseX <= point2.x and mouseY <= point2.y) then
		func()
	end
end