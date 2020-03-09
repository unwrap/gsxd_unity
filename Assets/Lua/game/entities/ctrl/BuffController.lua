
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.ctrl.BuffController
--date:2019/10/15 10:27:37
--author:heguang
--desc:buff管理
--
---------------------------------------------------------------------------------------------------
local BuffData = require("game.entities.data.BuffData")

local strClassName = 'game.entities.ctrl.BuffController'
local BuffController = lua_declare(strClassName, lua_class(strClassName))

function BuffController:ctor(owner)
	self.owner = owner

	self.buffs = {}
	self.overBuffs = {} --持续性的buff
end

function BuffController:dtor()
	
end

function BuffController:AddBuff(buffID, attacker)
	local buff_data = cfg_buff[buffID]
	if buff_data == nil then
		return
	end
	--是否叠加buff
	local overType = buff_data.overType
	if overType ~= nil and overType == 1 then
		local buff = BuffData(buffID, buff_data, self.owner, attacker)
		table.insert(self.overBuffs, buff)
		buff:Add()
	else
		local buff = self.buffs[buffID]
		if buff == nil then
			buff = BuffData(buffID, buff_data, self.owner, attacker)
			self.buffs[buffID] = buff
			buff:Add()
		else
			buff:ResetBuffTime()
		end
	end
end

function BuffController:RemoveBuff(buffID)
	local buffData = self.buffs[buffID]
	if buffData ~= nil then
		buffData:Remove()
	end
	self.buffs[buffID] = nil
end

function BuffController:Update(deltaTime)
	local t = {}
	for buffID,buffData in pairs(self.buffs) do
		buffData:Update(deltaTime)
		if buffData:IsEnd() then
			table.insert(t, buffID)
		end
	end
	for _,id in ipairs(t) do
		self:RemoveBuff(id)
	end

	for i=#self.overBuffs, 1, -1 do
		local buffData = self.overBuffs[i]
		buffData:Update(deltaTime)
		if buffData:IsEnd() then
			table.remove(self.overBuffs, i)
		end
	end
end

return BuffController
