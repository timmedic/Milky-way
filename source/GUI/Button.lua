require("GUI/GUI_base")

Button = {}

function Button:new(position, txt, width, height, col, fontSize)
	
	obj = GUIBase:new(position, DATA.gui.button)
	obj.updatable = true
	obj.txt = txt or "[empty message]"
	obj.width = width or string.len(obj.txt) * DATA.gui.charSize
	obj.height = height or obj.data.border * 2
	obj.col = col or Color.new(100, 100, 100)
	obj.font = Font.new(nil, DATA.gui.fontSize)
	if(fontSize) then obj.font = Font.new(nil, fontSize) end
	
	function obj:onClick()
		-- Here you can set your code for specific button
		print("this button have no func")
	end
	
	function obj:update()
		local realPosition = self.position + cameraPosition
		if(mouseLeftClicked and isMouseInBox(Vec2.new(realPosition.x - self.width/2 - self.data.border, realPosition.y - self.height/2), Vec2.new(realPosition.x + self.width/2 + self.data.border, realPosition.y + self.height/2))) then
			self:onClick()
			mouseLeftClicked = false
		end
	end
	
	function obj:draw()
		local drawPosition = self.position + cameraPosition
		if(isMouseInBox(Vec2.new(drawPosition.x - self.width/2 - self.data.border, drawPosition.y - self.height/2), Vec2.new(drawPosition.x + self.width/2 + self.data.border, drawPosition.y + self.height/2))) then
			rect(drawPosition.x - self.width/2 - self.data.border, drawPosition.y - self.height/2, drawPosition.x + self.width/2 + self.data.border, drawPosition.y + self.height/2, true, Color.new(self.col.r - 20, self.col.g - 20, self.col.b - 20))
		else
			rect(drawPosition.x - self.width/2 - self.data.border, drawPosition.y - self.height/2, drawPosition.x + self.width/2 + self.data.border, drawPosition.y + self.height/2, true, self.col)
		end
		font(self.font)
		text(self.txt, drawPosition.x - string.len(self.txt) * DATA.gui.charSize / 2, drawPosition.y - DATA.gui.charSize)
		font()
	end
	
	--table.insert(currentScene.GUI, obj)
	setmetatable(obj, self)
	self.__index = self; return obj
end