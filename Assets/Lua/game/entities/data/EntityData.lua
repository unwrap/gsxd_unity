
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.data.EntityData
--date:2019/10/10 16:26:31
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local SkillData = require("game.entities.data.SkillData")

local strClassName = 'game.entities.data.EntityData'
local EntityData = lua_declare(strClassName, lua_class(strClassName))

function EntityData:ctor(owner)
	self.owner = owner

	self.hp = 0

	self.bulletForward = 1 --正向箭
	self.bulletBackward = 0 --背向箭
	self.bulletSide = 0 --斜向箭
	self.bullet4Side = 0 --两侧箭
	self.bulletRound = 0 --圆形子弹
	self.bulletTurbine = 0  --涡轮型子弹

	self.bulletContinue = 0 --连续射击

	self.throughWall = false
	self.reboundWall = 0 --墙壁反弹次数

	self.arrowEjectCount = 0 --弹射次数
	self.throughEnemy = 0 --穿透次数

	self.headShot = 0 --爆头概率
	self.critRate = 0 --暴击概率
	self.critDmgAdd = 0 --暴击加成
	self.attackAdd = 0 --攻击加成
	self.attackSpeedAdd = 0 --攻击速度加成

	self.baseWeaponData = nil
	self.baseSkills = {}
	self.isBaseSkillInstall = false

	self.onceWeaponData = nil
	self.onceSkills = nil
end

function EntityData:SetCharacter(cfgChar, attackInc, maxHPInc, bodyHitInc)
	self.charData = cfgChar
	self.inc_attack = attackInc or 0
	self.inc_maxHP = maxHPInc or 0
	self.inc_bodyHit = bodyHitInc or 0

	self.critRate = self.charData.critRate or 0
	self.hp = self:GetEntityMaxHP()

	local stateLogic = self.charData.stateLogic
	if stateLogic == nil then
		stateLogic = "guai"
	end
	self.stateCfg = require("game.entities.char." .. stateLogic)

	self.baseWeaponData = cfg_weapon[self.charData.weaponID]
	if self.charData.skills ~= nil then
		for _,skillID in ipairs(self.charData.skills) do
			local skillData = SkillData(skillID, self)
			table.insert(self.baseSkills, skillData)
		end
	end

	self.onceWeaponData = nil
end

function EntityData:SetOnceWeapon(weaponid, skills)
	if weaponid == nil then
		self.onceWeaponData = nil
	else
		self.onceWeaponData = cfg_weapon[weaponid]
	end

	if skills ~= nil then
		self:UninstallBaseSkills()
		self.onceSkills = {}
		for _,skillID in ipairs(skills) do
			local skillData = SkillData(skillID, self)
			skillData:Install()
			table.insert(self.onceSkills, skillData)
		end
	else
		if weaponid == nil then
			self:InstallBaseSkills()
		else
			self:UninstallBaseSkills()
		end
	end
end

function EntityData:CleanOnceWeapon()
	self.onceWeaponData = nil
	if self.onceSkills ~= nil then
		for _,skillData in ipairs(self.onceSkills) do
			skillData:Uninstall()
		end
	end
	self.onceSkills = nil
end

function EntityData:InstallBaseSkills()
	if self.isBaseSkillInstall then
		return
	end
	for _,skillData in ipairs(self.baseSkills) do
		skillData:Install()
	end
	self.isBaseSkillInstall = true
end

function EntityData:UninstallBaseSkills()
	if not self.isBaseSkillInstall then
		return
	end
	for _,skillData in ipairs(self.baseSkills) do
		skillData:Uninstall()
	end
	self.isBaseSkillInstall = false
end

function EntityData:GetWeaponData()
	if self.onceWeaponData ~= nil then
		return self.onceWeaponData
	end
	return self.baseWeaponData
end

function EntityData:OnDamage(dmg)
	self.hp = self.hp - dmg
	if self.hp < 0 then
		self.hp = 0
	end
end

function EntityData:GetStateCfg()
	return self.stateCfg
end

function EntityData:GetStateOrder()
	if self.stateCfg ~= nil then
		return self.stateCfg.state_order
	end
end

--是否爆头
function EntityData:CheckHeadShot()
	local r = Random.value
	if self.headShot >= r then
		return true
	end
	return false
end

--是否暴击
function EntityData:CheckCrit()
	local r = Random.value
	if self.critRate >= r then
		return true
	end
	return false
end

function EntityData:GetThrouthEnemy()
	return self.throughEnemy > 0
end

function EntityData:AddSkill(skillID)
	local skillData = SkillData(skillID, self)
	skillData:Install()
	table.insert(self.baseSkills, skillData)
	return skillData
end

function EntityData:RemoveSkill(skillData)
	for i=#self.baseSkills, 1, -1 do
		local s = self.baseSkills[i]
		if s == skillData then
			skillData:Uninstall()
			table.remove(self.baseSkills, i)
		end
	end
end

function EntityData:RemoveAllSkill()
	for _,skillData in ipairs(self.baseSkills) do
		skillData:Uninstall()
	end
	self.baseSkills = {}
end

function EntityData:GetAttackSpeedAdd()
	return self.attackSpeedAdd
end

function EntityData:GetBodyMass()
	if self.charData ~= nil and self.charData.bodyMass ~= nil then
		return self.charData.bodyMass
	end
	return 2
end

function EntityData:GetEntityMaxHP()
	if self.charData ~= nil and self.charData.maxHP ~= nil then
		return self.charData.maxHP * (1 + self.inc_maxHP)
	end
	return 0
end

function EntityData:GetEntityAttack(crit)
	if self.charData ~= nil and self.charData.attack ~= nil then
		--是否暴击
		local dmg = self.charData.attack * (1 + self.inc_attack + self.attackAdd)
		if crit then
			dmg = dmg * (1 + self.critDmgAdd)
		end
		return dmg
	end
	return 0
end

function EntityData:GetEntityBodyHit()
	if self.charData ~= nil and self.charData.bodyHit ~= nil then
		return self.charData.bodyHit * (1 + self.inc_bodyHit)
	end
	return 0
end

function EntityData:GetEntityMoveSpeed()
	if self.charData ~= nil and self.charData.moveSpeed ~= nil then
		return self.charData.moveSpeed
	end
	return 2
end

function EntityData:GetBulletKnockback()
	local weaponData = self:GetWeaponData()
	if weaponData ~= nil and weaponData.knockBack ~= nil then
		return weaponData.knockBack
	end
	return 1
end

function EntityData:GetBulletMoveSpeed()
	local weaponData = self:GetWeaponData()
	if weaponData ~= nil and weaponData.speed then
		return weaponData.speed
	end
	return 0
end

function EntityData:GetBulletRotateAngle()
	local weaponData = self:GetWeaponData()
	if weaponData ~= nil and weaponData.rotateAngle then
		return weaponData.rotateAngle
	end
	return 0
end

function EntityData:GetBulletDistance()
	local weaponData = self:GetWeaponData()
	if weaponData ~= nil then
		return weaponData.distance
	end
	return 0
end

function EntityData:GetDeadDelayTime()
	local weaponData = self:GetWeaponData()
	if weaponData ~= nil and weaponData.deadDelay then
		return weaponData.deadDelay
	end
	return 0
end

function EntityData:GetDeadEffectName()
	local weaponData = self:GetWeaponData()
	if weaponData ~= nil then
		return weaponData.deadEffect
	end
end

function EntityData:GetBallistic()
	local weaponData = self:GetWeaponData()
	if weaponData ~= nil then
		return weaponData.ballistic
	end
	return 0
end

function EntityData:GetAliveTime()
	local weaponData = self:GetWeaponData()
	if weaponData ~= nil and weaponData.aliveTime ~= nil then
		return weaponData.aliveTime
	end
	return 0
end

function EntityData:GetRotateSpeed()
	local weaponData = self:GetWeaponData()
	if weaponData ~= nil and weaponData.rotateSpeed ~= nil then
		return weaponData.rotateSpeed
	end
	return 0
end

return EntityData
