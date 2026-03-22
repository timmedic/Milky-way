TextBox = {}

function TextBox:new(position, txt, lifeTime, bg, fontSize)
	
	obj = GUIBase:new(position, DATA.gui.textBox)
	obj.txt = txt
	obj.lifeTime = lifeTime or -1
	obj.bg = bg or Color.new(0, 0, 0, 100)
	obj.drawable = true
	obj.font = Font.new(nil, DATA.gui.fontSize)
	if(fontSize) then obj.font = Font.new(nil, fontSize) end

	function obj:draw()
		if(self.lifeTime > 0 ) then
			self.lifeTime = self.lifeTime - 1
		end
		
		if(self.lifeTime > 0 or self.lifeTime == -1) then
			local width, height = measure(self.txt, self.font)
			local drawPosition = self.position + cameraPosition
			rect(drawPosition.x - width/2 - self.data.border, drawPosition.y - height/2 - self.data.border/2, drawPosition.x + width/2 + self.data.border, drawPosition.y + height/2 + self.data.border/2, true, self.bg)
			font(self.font)
			text(self.txt, drawPosition.x - width/2, drawPosition.y - height/2, 1, 1)
			font()
		else
			self:removeObject()
		end
	end
	
	--table.insert(currentScene.GUI, obj)
	setmetatable(obj, self)
	self.__index = self; return obj
end