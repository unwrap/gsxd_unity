
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.page.BagPage
--date:2019/11/21 11:35:10
--author:heguang
--desc:背包页面
--
---------------------------------------------------------------------------------------------------

local MainPageBase = require("game.ui.page.MainPageBase")

local strClassName = 'game.ui.page.BagPage'
local BagPage = lua_declare(strClassName, lua_class(strClassName, MainPageBase))

function BagPage:OnShow()
	self.content = self:CreateContent("main/bagpage.u3d", "BagPage")
end

return BagPage
