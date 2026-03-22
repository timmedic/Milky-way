require("Entities/Spider_base.lua")

CommonSpider = {}

function CommonSpider:new(x0, y0, alwaysSeePlayer, stray, patrolPoints)
	
	obj = Spider:new(x0, y0, alwaysSeePlayer, stray, patrolPoints, DATA.entity.enemy.commonSpider)
	
	return obj
end