
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.page.StorePage
--date:2019/11/21 11:35:10
--author:heguang
--desc:商店页面
--
---------------------------------------------------------------------------------------------------

local MainPageBase = require("game.ui.page.MainPageBase")

local strClassName = 'game.ui.page.StorePage'
local StorePage = lua_declare(strClassName, lua_class(strClassName, MainPageBase))

function StorePage:OnShow()
	self.content = self:CreateContent("main/storepage.u3d", "StorePage")

	local store = self.content:Find("Store")
	local numChild = store.childCount
	for i=0, numChild-1 do
		local childTransform =store:GetChild(i)
		local btn = childTransform:Find("ButtonAdd")
		EventListener.Get(btn, self).onClick = self.OnClickItem
	end
end

function StorePage:OnClickItem(go)
	Dialog.ShowMessage("test", nil, true, false)
end

return StorePage
