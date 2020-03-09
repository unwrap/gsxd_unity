
---------------------------------------------------------------------------------------------------
--
--filename: game.ads.LuaAdsManager
--date:2019/12/16 22:10:43
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ads.LuaAdsManager'
local LuaAdsManager = lua_declare(strClassName, lua_class(strClassName))

function LuaAdsManager:ctor()

end

function LuaAdsManager:dtor()

end

function LuaAdsManager:PreloadAdSuccessCallback(msg)

end

function LuaAdsManager:PreloadAdFailedCallback(msg)

end

function LuaAdsManager:InterstitialLoadedCallback(msg)

end

function LuaAdsManager:InterstitialVideoLoadedCallback(msg)

end

function LuaAdsManager:AwardVideoLoadedCallback(msg)

end

function LuaAdsManager:AdShowSuccessCallback(scene, msg)

end

function LuaAdsManager:AdShowFailedCallback(scene, msg, err)

end

function LuaAdsManager:AdCloseCallback(scene, msg, award)
	Dialog.ShowMessage("AdClose:" .. scene .. ", Callback:" .. msg .. ", Award:" .. tostring(award));
end

function LuaAdsManager:AdClickCallback(scene, msg)

end

return LuaAdsManager
