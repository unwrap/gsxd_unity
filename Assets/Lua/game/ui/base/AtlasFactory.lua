
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.base.AtlasFactory
--date:2020/1/16 11:07:38
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'AtlasFactory'
local AtlasFactory = lua_declare(strClassName, lua_class(strClassName))
AtlasFactory._spriteDict = {}

function AtlasFactory:GetItemSprite(spriteName)
	local sp = AtlasFactory._spriteDict[spriteName]
	if sp == nil then
		--atlascommon
		local itemSprite = AssetBundleManager.LoadAsset("atlascommon.u3d", spriteName, Sprite)
		if itemSprite ~= nil then
			sp = {sp = itemSprite, ab = "atlascommon.u3d"}
		else
			itemSprite = AssetBundleManager.LoadAsset("atlasitem.u3d", spriteName, Sprite)
			if itemSprite ~= nil then
				sp = {sp = itemSprite, ab = "atlasitem.u3d"}
			end
		end
	end
	if sp then
		AtlasFactory._spriteDict[spriteName] = sp
		return sp.sp
	end
end

function AtlasFactory:ClearAllItem()
	for k,v in pairs(AtlasFactory._spriteDict) do
		AssetBundleManager.UnloadAssetBundle(v.ab,true)
	end
	AtlasFactory._spriteDict = {}
end

return AtlasFactory
