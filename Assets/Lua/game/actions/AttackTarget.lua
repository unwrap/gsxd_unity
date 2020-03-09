
---------------------------------------------------------------------------------------------------
--
--filename: game.actions.AttackTarget
--date:2019/10/8 9:55:08
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
require("game.bt.BehaviourNode")

local strClassName = 'AttackTarget'
local AttackTarget = lua_declare(strClassName, lua_class(strClassName, BehaviourNode))

function AttackTarget:ctor(triggerName)
	BehaviourNode.ctor(self, nil, true)
	self.triggerName = triggerName
	if self.triggerName == nil then
		self.triggerName = "attack"
	end
end

function AttackTarget:Visit()
	local owner = self:GetOwner()
	if self.status == BehaviourNode.READY then
		self.status = BehaviourNode.RUNNING
		if not owner:GetIsMoving()  and not owner.isAttacking then
			owner:DoAttack(self.triggerName)
		end
	end
	if self.status ==BehaviourNode.RUNNING then
		if not owner.isAttacking then
			self.status = BehaviourNode.SUCCESS
		end
	end
end

return AttackTarget
