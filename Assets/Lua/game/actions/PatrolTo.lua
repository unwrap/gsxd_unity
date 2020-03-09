
---------------------------------------------------------------------------------------------------
--
--filename: game.actions.PatrolTo
--date:2019/10/23 10:49:30
--author:heguang
--desc:巡逻行为
--
---------------------------------------------------------------------------------------------------
require("game.bt.BehaviourNode")

local strClassName = 'game.actions.PatrolTo'
local PatrolTo = lua_declare(strClassName, lua_class(strClassName, BehaviourNode))

function PatrolTo:ctor(range)
	BehaviourNode.ctor(self, nil, true)
	self.kind = "PatrolTo"
	self.patrolRange = range or 1
	self.targetPosition = Vector3.zero
	self.stopTime = 0.5
end

function PatrolTo:Reset()
	BehaviourNode.Reset(self)
	self.targetPosition = Vector3.zero
end

--选择一个点进行巡逻
function PatrolTo:Pick()
	local owner = self:GetOwner()
	local bornPosition = owner:GetBornPosition()
	local x = bornPosition.x + math.random(-self.patrolRange, self.patrolRange)
	local z = bornPosition.z + math.random(-self.patrolRange, self.patrolRange)
	self.targetPosition.x = x
	self.targetPosition.z = z
end

function PatrolTo:Visit()
	local owner = self:GetOwner()
	if self.status == BehaviourNode.READY then
		self:Pick()
		owner:MoveTo(self.targetPosition)
		self.status = BehaviourNode.RUNNING
	end
	if not owner:GetIsMoving() then
		self.status = BehaviourNode.SUCCESS
	end
end

return PatrolTo
