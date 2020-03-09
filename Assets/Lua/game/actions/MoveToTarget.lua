
---------------------------------------------------------------------------------------------------
--
--filename: game.actions.MoveToTarget
--date:2019/10/25 14:11:01
--author:heguang
--desc:移动向目标
--
---------------------------------------------------------------------------------------------------
require("game.bt.BehaviourNode")

local strClassName = 'game.actions.MoveToTarget'
local MoveToTarget = lua_declare(strClassName, lua_class(strClassName, BehaviourNode))

function MoveToTarget:ctor(distance_max)
	BehaviourNode.ctor(self, nil, true)
	self.distance_max = distance_max or 1
end

function MoveToTarget:Visit()
	local owner = self:GetOwner()
	if self.status == BehaviourNode.READY then
		if GameBattleManager.Instance() == nil then
			self.status = BehaviourNode.SUCCESS
			return
		end
		local entity = GameBattleManager.Instance().entityMgr:GetNearEntity(owner, 100, false)
		if entity == nil then
			self.status = BehaviourNode.SUCCESS
			return
		end
		local targetPos = entity:GetPosition()
		local currentPos = owner:GetPosition()
		local currentDis = Vector3.Distance(targetPos, currentPos)
		if currentDis < self.distance_max then
			self.status = BehaviourNode.SUCCESS
		else
			local dir = currentPos - targetPos
			dir.x = 0
			dir:Normalize()
			owner:MoveTo(entity:GetPosition() + dir * self.distance_max)
			self.status = BehaviourNode.RUNNING
		end
	end
	if self.status == BehaviourNode.RUNNING and (not owner:GetIsMoving()) then
		self.status = BehaviourNode.SUCCESS
	end
end

return MoveToTarget
