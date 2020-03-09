
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.data.SkillData
--date:2019/10/11 14:24:48
--author:heguang
--desc:装备的技能
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.entities.data.SkillData'
local SkillData = lua_declare(strClassName, lua_class(strClassName))

function SkillData:ctor(skillID, entityData)
	self.skill_id = skillID
	self.entityData = entityData
	self.skill_data = cfg_skill[skillID]

	self.attr2Data = {}
end

function SkillData:dtor()

end

function SkillData:Install()
	if self.skill_data ~= nil then
		if self.skill_data.attributes ~= nil then
			local att = self.skill_data.attributes
			if type(att[1]) == "table" then
				for _,v in ipairs(att) do
					self:HandlePlusAttribute(v)
				end
			else
				self:HandlePlusAttribute(att)
			end
		end
		if self.skill_data.buffs ~= nil then
			local buffs = self.skill_data.buffs
			if type(buffs) == "table" then
				for _,v in ipairs(buffs) do
					self:HandleAddBuff(v)
				end
			else
				self:HandleAddBuff(buffs)
			end
		end
	end
end

function SkillData:Uninstall()
	if self.skill_data ~= nil then
		if self.skill_data.attributes ~= nil then
			local att = self.skill_data.attributes
			if type(att[1]) == "table" then
				for _,v in ipairs(att) do
					self:HandleMinusAttribute(v)
				end
			else
				self:HandleMinusAttribute(att)
			end
		end
		if self.skill_data.buffs ~= nil then
			local buffs = self.skill_data.buffs
			if type(buffs) == "table" then
				for _,v in ipairs(buffs) do
					self:HandleRemoveBuff(v)
				end
			else
				self:HandleRemoveBuff(buffs)
			end
		end
	end
	self.attr2Data = {}
end

function SkillData:HandlePlusAttribute(v)
	local attrName = v[1]
	if self.entityData[attrName] == nil then
		return
	end
	local attrValue = 0
	if #v == 3 and v[3] then
		--按百分比计算
		attrValue = self.entityData[attrName] * v[2]
	else
		--按固定数值计算
		attrValue = v[2]
	end
	self.attr2Data[v] = attrValue
	self.entityData[attrName] = self.entityData[attrName] + attrValue
end

function SkillData:HandleMinusAttribute(v)
	local attrName = v[1]
	if self.entityData[attrName] == nil then
		return
	end
	local attrValue = self.attr2Data[v]
	if attrValue == nil then
		return
	end
	self.entityData[attrName] = self.entityData[attrName] - attrValue
end

function SkillData:HandleAddBuff(buffID)
	self.entityData.owner:AddBuff(buffID)
end

function SkillData:HandleRemoveBuff(buffID)
	self.entityData.owner:RemoveBuff(buffID)
end

return SkillData
