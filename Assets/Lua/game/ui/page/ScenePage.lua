
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.page.ScenePage
--date:2019/11/20 23:28:08
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local MainPageBase = require("game.ui.page.MainPageBase")

local strClassName = 'game.ui.page.ScenePage'
local ScenePage = lua_declare(strClassName, lua_class(strClassName, MainPageBase))

function ScenePage:OnShow()
	self.content = self:CreateContent("main/scenepage.u3d", "ScenePage")
	self.itemContainer = self.content:Find("Content")
	self.itemPrefab = self.itemContainer:Find("Item").gameObject
	self.itemPrefab:SetActive(false)

	self.maps = GlobalData:GetAllMaps()
	self.item2map = {}

	local coroutine = OzCoroutine(self.gameObject)

	local co = coroutine:create(function()
		for i=1,#self.maps do
			local map = self.maps[i]
			local item = GameUtil.Instantiate(self.itemPrefab)
			item.name = "map" .. map.mapId
			item:SetActive(true)
			local itemTransform = item.transform
			itemTransform:SetParent(self.itemContainer)
			itemTransform.localScale = Vector3.one

			local mapText = LuaGameUtil.GetTextComponent(itemTransform, "Text")
			mapText.text = map.mapName
			EventListener.Get(itemTransform, self).onClick = self.ClickMapItem
			self.item2map[item] = map
			yield(nil)
		end
		coroutine:clear()
		coroutine:destroy()
	end)
	coroutine:resume(co)
end

function ScenePage:ClickMapItem(go)
	local map = self.item2map[go]
	if map ~= nil then
		print(map.mapId)
		LuaGameUtil.LoadBattleScene(map.mapId)
	end
end

return ScenePage
