
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.data.BuffData
--date:2019/10/15 10:51:36
--author:heguang
--desc:单个buff数据
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.entities.data.BuffData'
local BuffData = lua_declare(strClassName, lua_class(strClassName))

function BuffData:ctor(buffID, data, owner, attacker)
	self.buffID = buffID
	self.owner = owner
	self.attacker = attacker
	self.entityData = self.owner.entityData
	self.buff_data = data

	self.isActive = false
	local lastTime = self.buff_data.lastTime
	if lastTime == nil or lastTime == 0 or lastTime >= 9999 then
		self.foreverBuff = true
	else
		self.foreverBuff = false
	end
	self.tickRate = self.buff_data.tickRate
	if self.tickRate == nil then
		self.tickRate = 0
	end
end

function BuffData:dtor()

end

function BuffData:IsEnd()
	if self.foreverBuff then
		return false
	end
	return Time.realtimeSinceStartup >= self.endTime 
end

function BuffData:Add()
	self:ResetBuffTime()
	self.isActive = true

	--检查特效
	local effectName = self.buff_data.effect
	if effectName ~= nil then
		self.effect = self.owner:PlayEffect(effectName)
	end
end

function BuffData:ResetBuffTime()
	local lastTime = self.buff_data.lastTime
	if lastTime == nil then
		lastTime = 0
	end
	self.startTime = Time.realtimeSinceStartup
	self.endTime = self.startTime + lastTime
	self.prevTickTime = self.startTime
	self:HandleTick()
end

function BuffData:Remove()
	if self.effect ~= nil then
		ObjectPool.Recycle(self.effect.gameObject)
		self.effect = nil
	end
end

function BuffData:HandleTick()
	local funcExtra = self.buff_data.excuteBuff
	if funcExtra ~= nil and self[funcExtra.func] then
		self[funcExtra.func](self, unpack(funcExtra.args))
	end
end

function BuffData:AddRangeBuff(buffID, range, sameteam)
	local rangeList = GameBattleManager.Instance().entityMgr:GetRoundSelfEntities(self.owner, range, sameteam)
	if rangeList ~= nil then
		for _,entity in ipairs(rangeList) do
			entity:AddBuff(buffID)
		end
	end
end

function BuffData:Line2NearEntity(range)
	local nearEntity = GameBattleManager.Instance().entityMgr:GetNearEntity(self.owner, range, false)
	if nearEntity ~= nil then
		if self.line == nil then
			self.line = ObjectPool.Spawn(LuaGameUtil.GetEffectAbName("lifeline"))
			local lineFinishCallback = function()
				self.line = nil
				self.lineCtrl = nil
			end
			self.lineCtrl = LuaGameUtil.DoFile(self.line, "game.effect.LifeLineCtrl")
			self.lineCtrl.finishCallback = lineFinishCallback
		end
		self.lineCtrl:UpdateEntity(self.owner, nearEntity)
	else
		self:RemoveLine()
	end
end

function BuffData:RemoveLine()
	if self.lineCtrl ~= nil then
		self.lineCtrl:Finish()
		self.lineCtrl = nil
	end
end

function BuffData:Update(deltaTime)
	if not self.isActive then
		return
	end

	if self.tickRate > 0 then
		local nextTickTime = self.prevTickTime + self.tickRate
		while nextTickTime <= Time.realtimeSinceStartup and (not self:IsEnd()) do
			self:HandleTick()
			self.prevTickTime = nextTickTime
			nextTickTime = self.prevTickTime + self.tickRate
		end
	end
end

return BuffData
