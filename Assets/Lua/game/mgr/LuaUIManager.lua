
---------------------------------------------------------------------------------------------------
--
--filename: game.mgr.LuaUIManager
--date:2020/1/7 21:03:45
--author:heguang
--desc:UIπ‹¿Ì
--
---------------------------------------------------------------------------------------------------
local strClassName = 'LuaUIManager'
local LuaUIManager = lua_declare(strClassName, lua_class(strClassName))

function LuaUIManager:Show(obj, strName)
	local objTransform = obj.transform
	objTransform:SetParent(UIManager.Instance.ContentRoot)
	objTransform.offsetMax = Vector2.zero
    objTransform.offsetMin = Vector2.zero
    objTransform.anchorMin = Vector2.zero
    objTransform.anchorMax = Vector2.one
	objTransform.localScale = Vector3.one
end

function LuaUIManager:Start()

end

return LuaUIManager
