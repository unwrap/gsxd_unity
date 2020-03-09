
---------------------------------------------------------------------------------------------------
--
--filename: game.util.LuaGameUtil
--date:2019/9/20 16:16:06
--author:xxx
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.util.LuaGameUtil'
local LuaGameUtil = lua_declare("LuaGameUtil", lua_class(strClassName))
LuaGameUtil.canHitDir = Vector3.zero
LuaGameUtil.pauseFlag = 0
LuaGameUtil.gamePaused = false

function LuaGameUtil.SetPause(pause)
	local inc = pause and 1 or -1
	LuaGameUtil.pauseFlag = LuaGameUtil.pauseFlag + inc
	local val = LuaGameUtil.pauseFlag > 0
	if LuaGameUtil.gamePaused ~= val then
		LuaGameUtil.gamePaused = val
		OzMessage:dispatchEvent(CommonEvent.PauseStateChange, LuaGameUtil.gamePaused)
	end
end

function LuaGameUtil.IsPaused()
	return LuaGameUtil.gamePaused
end

function LuaGameUtil.GetText(id)
	local cfgItem = cfg_localization[id]
	if cfgItem ~= nil then
		return cfgItem.content
	end
	return string.format("[ERROR- %d ]", id);
end

function LuaGameUtil.FormatText(id, ...)
	local cfgItem = cfg_localization[id]
	if not cfgItem then
		return string.format("[ERROR- %d ]", id);
	end
	local fmt = cfgItem.content
	local parms = {...}
	local function search(k)
		k = k + 1
		if k > #parms or k < 0 then
			return ""
		end
		return tostring(parms[k])
	end
	return (string.gsub(fmt, "{(%d)}", search))
end

function LuaGameUtil.IsSameTeam(e1, e2)
	if e1 == nil or e2 == nil then
		return false
	end
	return e1.entityType == e2.entityType
end

function LuaGameUtil.GetCanHit(me, other)
	if me == nil or other == nil then
		return false
	end
	local pos1 = me:GetPosition()
	local pos2 = other:GetPosition()
	LuaGameUtil.canHitDir.x = pos2.x - pos1.x
	LuaGameUtil.canHitDir.z = pos2.z - pos1.z
	LuaGameUtil.canHitDir.y = 0

	local layer = GameUtil.CullingLayer(LayerManager.MapOutWall, LayerManager.Obstruct)
	local hits = GameUtil.Raycast(pos1, LuaGameUtil.canHitDir, LuaGameUtil.canHitDir.magnitude, layer)
	if hits ~= nil then
		for i=1, #hits do
			local hit = hits[i]
			if hit.collider ~= nil and hit.collider.gameObject ~= nil then
				local hitObj = hit.collider.gameObject
				if hitObj.layer == LayerManager.MapOutWall or hitObj.layer == LayerManager.Obstruct then
					return false
				end
			end
		end
	end

	return true
end

function LuaGameUtil.GetBulletAbName(bulletName)
	return "bullet/" .. string.lower(bulletName) .. ".u3d", bulletName
end

function LuaGameUtil.GetEffectAbName(effectName)
	return "effect/" .. string.lower(effectName) .. ".u3d", effectName
end

function LuaGameUtil.GetBulletAngle(current, count, allAngle)
	local num = allAngle / (count - 1)
	return (current * num) - (allAngle * 0.5)
end

function LuaGameUtil.LoadHomeScene()
	local gameBattleMgr = GameBattleManager.Instance()
	if gameBattleMgr ~= nil then
		gameBattleMgr:OnDestroy()
	end
	LuaGameUtil.LoadLevel("main", false)
end

function LuaGameUtil.LoadBattleScene(mapId)
	local gameBattleMgr = GameBattleManager()
	gameBattleMgr:LoadScene(mapId)
end

LuaGameUtil.isLoadingLevel = false
function LuaGameUtil.LoadLevel(levelName, isBattleScene)
	if LuaGameUtil.isLoadingLevel then
		return
	end
	OzMessage:dispatchEvent(CommonEvent.ShowSceneTransition, levelName, isBattleScene)
end

function LuaGameUtil.DoFile(obj, fn, forceDoFile)
	if forceDoFile == nil then
		forceDoFile = false
	end
	local luaMono = GameUtil.GetComponent(obj, LuaMonoBehaviour)
	if luaMono == nil then
		luaMono = GameUtil.AddComponent(obj, LuaMonoBehaviour)
	end
	if luaMono == nil then
		return
	end
	return luaMono:DoFile(fn, forceDoFile)
end

function LuaGameUtil.GetTextComponent(parent,name)
	local obj = parent:FindChild(name)
	if obj == nil then
		return nil
	end
	return obj:GetComponent(Text)
end

function LuaGameUtil.GetImageComponent(parent,name)
	local obj = parent:FindChild(name)
	if obj == nil then
		return nil
	end
	return obj:GetComponent(Image)
end


return LuaGameUtil
