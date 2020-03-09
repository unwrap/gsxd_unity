
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.page.MainPageBase
--date:2019/11/20 22:27:39
--author:heguang
--desc:主界面分页
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.page.MainPageBase'
local MainPageBase = lua_declare(strClassName, lua_class(strClassName))

function MainPageBase:SetPosition(pos, index)
	self.pos = pos
	self.index = index
	self.isShow = false
end

function MainPageBase:CreateContent(assetBundleName, assetName)
	local obj = AssetBundleManager.InstantiateGameObject(assetBundleName, assetName)
	obj.name = assetName
	local objTransform = obj.transform
	objTransform:SetParent(self.transform)
	objTransform.offsetMax = Vector2.zero
    objTransform.offsetMin = Vector2.zero
    objTransform.anchorMin = Vector2.zero
    objTransform.anchorMax = Vector2.one
	objTransform.localScale = Vector3.one

	return objTransform
end

function MainPageBase:ShowPage()
	if self.isShow then
		return
	end
	self.isShow = true
	self:OnShow()
end

function MainPageBase:OnShow()
	
end

function MainPageBase:OnHide()
	
end

return MainPageBase
