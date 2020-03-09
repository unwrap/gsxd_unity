
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.MainContent
--date:2019/11/19 22:37:59
--author:heguang
--desc:主界面
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.MainContent'
local MainContent = lua_declare(strClassName, lua_class(strClassName))

function MainContent:Start()
	local center = self.transform:Find("Center")
	local bottomCenter = self.transform:Find("BottomCenter")

	self.bottomCtrl = LuaGameUtil.DoFile(bottomCenter.gameObject, "game.ui.MainBottom")
	self.horizontalScroll = LuaGameUtil.DoFile(center.gameObject, "game.ui.MainPageScrollSnap")

	self.currentPage = 3
	self:MainPageChange(self.currentPage)

	OzMessage:addEvent(CommonEvent.MainPageChange, self.MainPageChange, self)

	OzMessage:dispatchEvent(CommonEvent.ShowGMPanel)

	--GameNetMgr.Send.C2R_Ping({RpcId = 200})
end

function MainContent:OnDestroy()
	OzMessage:removeEvent(CommonEvent.MainPageChange, self.MainPageChange, self)
end

function MainContent:MainPageChange(idx)
	self.currentPage = idx
	self.bottomCtrl:SetCurrentIndex(self.currentPage)
	self.horizontalScroll:SetCurrentPageIndex(self.currentPage)
end

return MainContent
