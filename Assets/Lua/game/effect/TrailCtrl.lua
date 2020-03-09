
---------------------------------------------------------------------------------------------------
--
--filename: game.effect.TrailCtrl
--date:2019/10/18 9:35:58
--author:heguang
--desc:拖尾效果管理
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.effect.TrailCtrl'
local TrailCtrl = lua_declare(strClassName, lua_class(strClassName))

function TrailCtrl:ctor(trail)
	self.trailObj = trail.gameObject
	self:InitParticles()
end

function TrailCtrl:InitParticles()
	if self.trailObj ~= nil then
		self.mTrailParticles = self.trailObj:GetComponentsInChildren(ParticleSystem)
	end
end

function TrailCtrl:TrailShow(show)
	if self.trailObj ~= nil then
		self.trailObj:SetActive(show)
	end
end

return TrailCtrl
