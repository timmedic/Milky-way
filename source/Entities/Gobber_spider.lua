require("Entities/Spider_base.lua")

GobberSpider = {}

function GobberSpider:new(x0, y0, alwaysSeePlayer, stray, patrolPoints)
	
	obj = Spider:new(x0, y0, alwaysSeePlayer, stray, patrolPoints, DATA.entity.enemy.gobberSpider)
	
	function obj:hit(object)
		self:shootTo(object)
	end
	
	function obj:shootTo(object)
		CobwebShell:new(self.position, object.position, self)
	end
	
	function obj:isNeedsGoNext()
		return ( (self.position:distanceTo(self.target.position) >= self.data.speed * 2) and not (self.target.object.data.name == "Player" and self:isMayHitThis(self.target)) )
	end
	
	return obj
end