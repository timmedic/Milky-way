TaskBase = {}

function TaskBase:new(taskType, targetName, count)
	
	obj = Object:new(false, true, DATA.other.task)
	obj.position = obj.data.position + Vec2.new(-1 * DATA.gui.charSize * (string.len(taskType) + string.len(targetName)), #currentScene.tasks * (DATA.gui.charSize + obj.data.offset))
	obj.taskType = taskType
	obj.targetName = targetName
	obj.count = 0
	obj.targetCount = count or 1
	obj.completed = false
	
	function obj:addCount(count)
		self.count = self.count + count
		if(self.count >= self.targetCount) then
			self.count = self.targetCount
			self.completed = true
		end
		self.counter.count = self.count
	end

	function obj:isCompleted()
		return self.completed
	end
	
	function obj:draw()
		if(self.counter) then
			self.counter:draw()
		else
			self.counter = Counter:new(self.position, self.taskType .. self.targetName, self.count, self.targetCount)
		end
	end
	
	table.insert(currentScene.tasks, obj)
	return obj
end

function checkTasks(targetName, count)
	local count = count or 1
	for i, task in pairs(currentScene.tasks) do
		if(task.completed == false and task.targetName == targetName) then
			task:addCount(count)
		end
	end
end

function isAllTasksCompleted()
	for i, task in pairs(currentScene.tasks) do
		if not(task:isCompleted()) then
			return false
		end
	end
	return true
end