
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.battle.NextWaveInfo
--date:2020/1/8 23:16:01
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.battle.NextWaveInfo'
local NextWaveInfo = lua_declare(strClassName, lua_class(strClassName))

function NextWaveInfo:Start()
	self.content = self.transform:Find("Content")
	self.timeText = LuaGameUtil.GetTextComponent(self.content, "LeftTimeText")
	self.waveText = LuaGameUtil.GetTextComponent(self.content, "WaveText")

	self.isVisible = false
	self.content.gameObject:SetActive(self.isVisible)
	OzMessage:addEvent(CommonEvent.UpdateNextWaveMonsterTime, self.UpdateNextWaveMonsterTime, self)
end

function NextWaveInfo:OnDestroy()
	OzMessage:removeEvent(CommonEvent.UpdateNextWaveMonsterTime, self.UpdateNextWaveMonsterTime, self)
end

function NextWaveInfo:UpdateNextWaveMonsterTime(t)
	if t > 0 then
		local lt = string.format("%.2f", t)
		self.timeText.text = LuaGameUtil.FormatText(400001, lt)
		if not self.isVisible then
			self.isVisible = true
			self.content.gameObject:SetActive(self.isVisible)
		end
	else
		if self.isVisible then
			self.isVisible = false
			self.content.gameObject:SetActive(self.isVisible)
		end
	end
end

return NextWaveInfo
