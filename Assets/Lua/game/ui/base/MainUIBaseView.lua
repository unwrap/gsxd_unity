
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.base.MainUIBaseView
--date:2020/1/7 21:20:46
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.base.MainUIBaseView'
local MainUIBaseView = lua_declare(strClassName, lua_class(strClassName))

function MainUIBaseView:Start()
	self.canvasGroup = GameUtil.AddComponent(self.gameObject, CanvasGroup)
end

function MainUIBaseView:SetTargetObject(go, strName)
	self.targetObject = go
	self.targetObjectName = strName
end

function MainUIBaseView:Show()
	self.targetObject:SetActive(true)
	self.canvasGroup.alpha = 0
	LeanTween.alphaCanvas(self.canvasGroup, 1, 0.3)
end

function MainUIBaseView:Hide()
	self.targetObject:SetActive(false)
end

function MainUIBaseView:Remove()
	self.targetObject = nil
	GameUtil.Destroy(self.gameObject)
end

return MainUIBaseView
