
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.ctrl.AnimationCtrlBase
--date:2019/9/24 23:41:14
--author:heguang
--desc:动画控制
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.entities.ctrl.AnimationCtrlBase'
local AnimationCtrlBase = lua_declare(strClassName, lua_class(strClassName))
AnimationCtrlBase.idleState = Animator.StringToHash("BaseLayer.Idle")
AnimationCtrlBase.runState = Animator.StringToHash("BaseLayer.Run")
AnimationCtrlBase.deathState = Animator.StringToHash("BaseLayer.Death")
AnimationCtrlBase.attackState = Animator.StringToHash("BaseLayer.Attack")

local math_floor = math.floor

function AnimationCtrlBase:ctor(owner, anim, rigidbody)
	self.owner = owner
	self.anim = anim
	self.rigidbody = rigidbody
	self.isDeadEnd = false

	self.isForcePaused = false
	self.pausedTimer = 0
	self.pausedTime = 0
	self.prevSpeed = 0

	self.isCheckLoop = false
	self.loopCount = 0

	self.attackSpeed = self.anim:GetFloat("AttackSpeed")
	self.attackSpeedAdd = 1
end

function AnimationCtrlBase:SetAnimController(animState)
	self.anim.runtimeAnimatorController = ResManager.GetAnimController(animState)
	self.currentAnimStateHash = 0
	self.nextAnimStateHash = 0
	self.currentStatePrecent = 0
	self.nextStatePrecent = 0

	self.anim:Play(AnimationCtrlBase.idleState)
	self.anim:Update(0)

	self.isDeadEnd = false
end

function AnimationCtrlBase:SetAnimStateConfig(stateCfg)
	self.stateCfg = stateCfg
	self.stateHash2Value = {}
	for k,v in pairs(self.stateCfg) do
		local kHash = Animator.StringToHash("BaseLayer." .. k )
		if string.StartWith(k, "Attack") and (v.attack_end == nil) then
			if v.operation == nil then
				v.operation = {}
				v.operation[99] =  {attack_end = true}
			else
				local v1 = v.operation[99] or {}
				v1.attack_end = true
				v.operation[99] = v1
			end
		end
		self.stateHash2Value[kHash] = v
	end
end

function AnimationCtrlBase:SetPause(val)
	if not Slua.IsNull(self.anim) then
		self.anim.enabled = not val
	end
	if not Slua.IsNull(self.rigidbody) then
		if val then
			self.rigidbody.isKinematic = true
			--self.rigidbody.velocity = Vector3.zero
			--self.rigidbody.angularVelocity = Vector3.zero
			self.rigidbody:Sleep()
		else
			self.rigidbody.isKinematic = false
			self.rigidbody:WakeUp()
		end
	end
end

function AnimationCtrlBase:SetSpeed(speed)
	self.anim:SetFloat("Speed", speed)
end

function AnimationCtrlBase:DoDamage()
	if self.owner:IsDead() then
		return
	end
	if self.owner.isAttacking then
		return
	end
	self.anim:SetTrigger("Damage")
end

function AnimationCtrlBase:AddAttackEndEvent(aniName)
	local kHash = Animator.StringToHash("BaseLayer." .. aniName)
	local v = self.stateHash2Value[kHash] or {}

	if v.operation == nil then
		v.operation = {}
		v.operation[99] =  {attack_end = true}
	else
		local v1 = v.operation[99] or {}
		v1.attack_end = true
		v.operation[99] = v1
	end
	self.stateHash2Value[kHash] = v
end

function AnimationCtrlBase:CleanAttackFlag(aniName)
	if aniName ~= nil then
		self.anim:SetBool(aniName, false)
	end
end

function AnimationCtrlBase:DoAttack(aniName)
	--self.anim:SetTrigger(aniName)
	self.anim:SetBool(aniName, true)
end

function AnimationCtrlBase:DoDeath()
	self.anim:SetTrigger("Death")
end

function AnimationCtrlBase:HandleAnimationEvent(nameHash, framePrecent)
	--print(nameHash, framePrecent, framePrecent % 100)
	framePrecent = framePrecent % 100
	if self.stateHash2Value ~= nil then
		local stateObj = self.stateHash2Value[nameHash]
		if stateObj ~= nil then
			local ops = stateObj.operation
			if ops ~= nil then
				local op = ops[framePrecent]
				if op ~= nil then
					self:HandleOperation(op)
				end
			end
		end
	end

	if AnimationCtrlBase.deathState == nameHash and framePrecent == 99 then
		if not self.isDeadEnd then
			self.owner:OnDeadEnd()
			self.isDeadEnd = true
		end
	end
end

function AnimationCtrlBase:HandleOperation(op)
	if op.fire_bullet ~= nil then
		self.owner:OnWeaponAttack(op.fire_bullet.weaponid, op.fire_bullet.skills)
	end
	if op.attack_end ~= nil then
		self.owner:OnAttackEnd()
	end
	if op.melee_attack ~= nil then
		local ret = op.melee_attack
		if ret then
			self.owner:OnShortAttackStart()
		else
			self.owner:OnShortAttackEnd()
		end
	end
	if op.move_speed ~= nil then
		self.owner:ForceMove(op.move_speed)
	end
	if op.jump_speed ~= nil then
		local jumpSpeed = op.jump_speed
		self.owner:Jump(jumpSpeed)
	end
	if op.frame_pause ~= nil then
		self.isForcePaused = true
		self.pausedTime = op.frame_pause
		self.pausedTimer = 0
		self.prevSpeed = self.anim.speed
		self.anim.speed = 0
	end
	if op.warning ~= nil then
		self.owner:ShowLine(op.warning.rebound)
	end
	if op.warning_end ~= nil then
		self.owner:HideLine()
	end
	if op.attack_speed ~= nil then
		self:SetAttackSpeed(op.attack_speed)
	end
	if op.stop_aim then
		self.owner:StopAimTarget()
	end
end

function AnimationCtrlBase:SetAttackSpeed(sp)
	if self.anim == nil then
		return
	end
	self.attackSpeed = sp
	self.anim:SetFloat("AttackSpeed", self.attackSpeed + self.attackSpeedAdd)
	--print("****", self.attackSpeed, self.attackSpeed + self.attackSpeedAdd, self.anim:GetFloat("AttackSpeed"))
	self.anim:Update(0)
end

function AnimationCtrlBase:Update()
	if LuaGameUtil.IsPaused() then
		return
	end

	local asAdd = self.owner.entityData:GetAttackSpeedAdd()
	if self.attackSpeedAdd ~= asAdd then
		self.attackSpeedAdd = asAdd
		self:SetAttackSpeed(self.attackSpeed)
	end

	if self.isForcePaused then
		self.pausedTimer = self.pausedTimer + Time.deltaTime
		if self.pausedTimer >= self.pausedTime then
			self.isForcePaused = false
			self.anim.speed = self.prevSpeed
		end
		return
	end

	--因为状态转换过渡的原因，有可能两个状态都存在。这里的处理方式是同时处理两个状态的事件
	local currentState = self.anim:GetCurrentAnimatorStateInfo(0)
	local nextState = self.anim:GetNextAnimatorStateInfo(0)


	local currentStateHash = currentState.fullPathHash
	local nextStateHash = nextState.fullPathHash

	if self.currentAnimStateHash ~= currentStateHash then
		if self.currentStatePrecent > 0 then
			while self.currentStatePrecent <= 100 do
				self:HandleAnimationEvent(self.currentAnimStateHash, self.currentStatePrecent)
				self.currentStatePrecent = self.currentStatePrecent + 1
			end
		end
		--继承下一个状态的进度
		self.currentAnimStateHash = currentStateHash
		self.currentStatePrecent = self.nextStatePrecent

		if self.stateHash2Value ~= nil then
			local stateObj = self.stateHash2Value[currentStateHash]
			if stateObj ~= nil then
				--table.print(stateObj)
				if stateObj.attack_speed ~= nil then
					self:SetAttackSpeed(stateObj.attack_speed)
					currentState = self.anim:GetCurrentAnimatorStateInfo(0)
				else
					self:SetAttackSpeed(1)
					currentState = self.anim:GetCurrentAnimatorStateInfo(0)
				end

				if stateObj.loop_times ~= nil and stateObj.loop_times > 0 then
					self.loopCount = stateObj.loop_times - 1
					if self.loopCount < 1 then
						self.loopCount = 1
					end
					self.isCheckLoop = true
					self.anim:SetInteger("LoopTime", stateObj.loop_times)
					self.anim:Update(0)
					currentState = self.anim:GetCurrentAnimatorStateInfo(0)
				end
			else
				self:SetAttackSpeed(1)
				currentState = self.anim:GetCurrentAnimatorStateInfo(0)
			end
		end
	end

	local currentPrecent = math_floor((currentState.normalizedTime) * 100)
	--print(currentState.normalizedTime, "***", currentPrecent, currentPrecent % 100)
	while self.currentStatePrecent <= currentPrecent do
		self:HandleAnimationEvent(self.currentAnimStateHash, self.currentStatePrecent)
		self.currentStatePrecent = self.currentStatePrecent + 1
	end

	--处理下一个状态的逻辑需要写在处理当前状态之后。
	if self.nextAnimStateHash ~= nextStateHash then
		self.nextAnimStateHash = nextStateHash
		self.nextStatePrecent = 0
	end
	if self.nextAnimStateHash ~= 0 then
		local nextPrecent = math_floor(nextState.normalizedTime * 100)
		while self.nextStatePrecent <= nextPrecent do
			self:HandleAnimationEvent(self.nextAnimStateHash, self.nextStatePrecent)
			self.nextStatePrecent = self.nextStatePrecent + 1
		end
	end
	
	if self.isCheckLoop then
		if currentState.normalizedTime >= self.loopCount then
			self.isCheckLoop = false
			self.anim:SetInteger("LoopTime", 0)
			self.anim:Update(0)
			currentState = self.anim:GetCurrentAnimatorStateInfo(0)
		end
	end

end

return AnimationCtrlBase
