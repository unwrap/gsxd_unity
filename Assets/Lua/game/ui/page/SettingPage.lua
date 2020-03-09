
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.page.SettingPage
--date:2019/11/21 11:35:10
--author:heguang
--desc:设置页面
--
---------------------------------------------------------------------------------------------------

local MainPageBase = require("game.ui.page.MainPageBase")

local strClassName = 'game.ui.page.SettingPage'
local SettingPage = lua_declare(strClassName, lua_class(strClassName, MainPageBase))

function SettingPage:OnShow()
	self.content = self:CreateContent("main/settingpage.u3d", "SettingPage")
end

return SettingPage
