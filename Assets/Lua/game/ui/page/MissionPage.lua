
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.page.MissionPage
--date:2019/11/21 11:35:10
--author:heguang
--desc:任务页面
--
---------------------------------------------------------------------------------------------------

local MainPageBase = require("game.ui.page.MainPageBase")

local strClassName = 'game.ui.page.MissionPage'
local MissionPage = lua_declare(strClassName, lua_class(strClassName, MainPageBase))

function MissionPage:OnShow()
	self.content = self:CreateContent("main/missionpage.u3d", "MissionPage")
end

return MissionPage
