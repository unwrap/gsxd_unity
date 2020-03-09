
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.battle.SelectSkill
--date:2020/1/7 21:58:03
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.battle.SelectSkill'
local SelectSkill = lua_declare(strClassName, lua_class(strClassName))

function SelectSkill:Start()
	self.itemList = {}
	
	local itemContainer = self.transform:Find("ItemList")
	local numChild = itemContainer.childCount
	for i=0, numChild-1 do
		local childObj = itemContainer:GetChild(i).gameObject
		table.insert(self.itemList, {obj = childObj})
		EventListener.Get(childObj, self).onClick = self.OnClickItem
	end
end

function SelectSkill:SetSkills(skills)
	local skillCount = #skills
	for i=1,#self.itemList do
		local item = self.itemList[i]
		local itemObj = item.obj
		if i <= skillCount then
			itemObj:SetActive(true)
			local skill = skills[i]
			item.skill = skill
			local itemName = LuaGameUtil.GetTextComponent(itemObj.transform, "Text")
			itemName.text = skill.name
			local itemImage = LuaGameUtil.GetImageComponent(itemObj.transform, "Icon")
			itemImage.sprite = AtlasFactory:GetItemSprite(skill.skillIcon)
		else
			itemObj:SetActive(false)
			item.skill = nil
		end
	end
end

function SelectSkill:OnClickItem(go)
	local skill = nil
	for i=1,#self.itemList do
		local item = self.itemList[i]
		if item.obj == go then
			skill = item.skill
		end
	end

	GameBattleManager.Instance():BattleStart(skill)
	self:CloseHandler()
end

function SelectSkill:CloseHandler()
	Dialog.Hide()
end

return SelectSkill
