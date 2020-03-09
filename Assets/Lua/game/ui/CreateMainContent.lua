
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.CreateMainContent
--date:2019/11/22 23:24:39
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.CreateMainContent'
local CreateMainContent = lua_declare(strClassName, lua_class(strClassName))

function CreateMainContent:Start()
	self.this:RunCoroutine(WaitForEndOfFrame(), self.StartCreate, self)
end

function CreateMainContent:StartCreate()
	local obj = AssetBundleManager.InstantiateGameObject("main/maincontent.u3d", "MainContent")
	local objTransform = obj.transform
	objTransform:SetParent(UIManager.Instance.ContentRoot)
	objTransform.offsetMax = Vector2.zero
    objTransform.offsetMin = Vector2.zero
    objTransform.anchorMin = Vector2.zero
    objTransform.anchorMax = Vector2.one
	objTransform.localScale = Vector3.one
end

return CreateMainContent
