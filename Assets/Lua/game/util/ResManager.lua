
---------------------------------------------------------------------------------------------------
--
--filename: game.util.ResManager
--date:2019/11/18 18:16:29
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'ResManager'
local ResManager = lua_declare(strClassName, lua_class(strClassName))

ResManager.animController = {}

function ResManager.GetAnimController(animController)
	if animController == nil then
		animController = "Animation_char"
	end
	local anim = ResManager.animController[animController] or AssetBundleManager.LoadAsset("animation/".. string.lower(animController) .. ".u3d", animController, RuntimeAnimatorController)
	ResManager.animController[animController] = anim
	return anim
end

return ResManager
