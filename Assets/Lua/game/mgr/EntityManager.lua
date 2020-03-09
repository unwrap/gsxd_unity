
---------------------------------------------------------------------------------------------------
--
--filename: game.mgr.EntityManager
--date:2019/10/7 7:41:11
--author:heguang
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.mgr.EntityManager'
local EntityManager = lua_declare(strClassName, lua_class(strClassName))

function EntityManager:ctor(entityObj, gameMgr)
	self.entityObj = entityObj
	self.gameMgr = gameMgr
	self.go2entity = {}
	local entityTransform = self.entityObj.transform

	local heroObj = entityTransform:Find("hero")
	local hero = nil
	if heroObj ~= nil then
		local heroTransform = heroObj:Find("thief")
		if heroTransform ~= nil then
			hero = heroTransform.gameObject
		end
	else
		heroObj = GameObject("hero").transform
		heroObj:SetParent(entityTransform)
		heroObj.localPosition = Vector3.zero
		heroObj.localScale = Vector3.one
	end
	if hero == nil then
		hero = ObjectPool.Spawn("role/thief.u3d", "thief")
		hero.transform:SetParent(heroObj)
		hero.transform.localScale = Vector3.one
		hero.transform.localPosition = Vector3.zero
		GameUtil.SetLayer(hero.transform, LayerManager.Player)
	end
	self.myself = LuaGameUtil.DoFile(hero, "game.entities.EntityHero")
	self.go2entity[hero] = self.myself
	
	self.monsterContainer = entityTransform:Find("monster")
	if self.monsterContainer == nil then
		self.monsterContainer = GameObject("monster").transform
		self.monsterContainer:SetParent(entityTransform)
		self.monsterContainer.localPosition = Vector3.zero
		self.monsterContainer.localScale = Vector3.one
	end
end

function EntityManager:BattleStart()
	for go,entity in pairs(self.go2entity) do
		entity:SetReady(true)
	end
end

function EntityManager:BattleStop()
	for go, entity in pairs(self.go2entity) do
		entity:SetReady(false)
	end
end

function EntityManager:FindRandomPosition(container)
	for i=1,50 do
		local x = Random.Range(-2, 2)
		local z = Random.Range(-2, 2)
		local localPos = Vector3(x, 0, z)
		local worldPos = container:TransformPoint(localPos)
		if self.gameMgr:IsWalkable(worldPos) then
			return worldPos
		end
	end
end

function EntityManager:CheckCanCreateMonster()
	local roomData = GlobalData.roomData
	local cfgWaveMonster = roomData:GetMapMonsters()
	if cfgWaveMonster == nil then
		return false, 0
	end
	local monsters = cfgWaveMonster.monsters
	if monsters == nil or #monsters <= 0 then
		return false, 0
	end
	return true, cfgWaveMonster.nextTime
end

function EntityManager:CreateMonster()
	local roomData = GlobalData.roomData
	local cfgWaveMonster = roomData:GetMapMonsters()
	if cfgWaveMonster == nil then
		return false, 0
	end
	local monsters = cfgWaveMonster.monsters
	if monsters == nil or #monsters <= 0 then
		return false, 0
	end
	roomData.waveIdx = roomData.waveIdx + 1
	for _,id in ipairs(monsters) do
		local cfgMonster = cfg_char[id]
		local worldPos = self:FindRandomPosition(self.monsterContainer)
		if cfgMonster ~= nil and worldPos ~= nil then
			local monsterObj = ObjectPool.Spawn("role/" .. cfgMonster.avatar .. ".u3d", cfgMonster.avatar)
			if monsterObj ~= nil then
				local monster = monsterObj.transform
				monster:SetParent(self.monsterContainer)
				monster.position = worldPos
				monster.rotation = Quaternion.Euler(0, 180, 0)
				GameUtil.SetLayer(monster, LayerManager.Player)
				local entityCtrl = LuaGameUtil.DoFile(monsterObj, "game.entities.EntityMonster")
				entityCtrl:SetCharacter(cfgMonster, cfgWaveMonster.attack, cfgWaveMonster.maxHP, cfgWaveMonster.bodyHit)
				monsterObj.name = "monster" .. cfgMonster.monsterID
				self.go2entity[monsterObj] = entityCtrl
			end
		end
	end
	return true, cfgWaveMonster.nextTime
end

function EntityManager:RemoveEntity(entity)
	local go = entity.gameObject
	self.go2entity[go] = nil
end

function EntityManager:GetEnemyNum()
	local num = 0
	for go, entity in pairs(self.go2entity) do
		if not LuaGameUtil.IsSameTeam(entity, self.myself) and not entity:IsDead() then
			num = num + 1
		end
	end
	return num
end

function EntityManager:FindEntity(go)
	return self.go2entity[go]
end

function EntityManager:FindTarget()
	local minDis = 100000
	local findTarget = nil

	local minCanHitDis = 100000
	local findCanHitTarget = nil

	for go,entity in pairs(self.go2entity) do
		if not LuaGameUtil.IsSameTeam(entity, self.myself) and not entity:IsDead() then
			local dis = Vector3.Distance(entity:GetPosition(), self.myself:GetPosition())
			if dis < minDis then
				findTarget = entity
				minDis = dis
			end
			local canHit = LuaGameUtil.GetCanHit(self.myself, entity)
			if dis < minCanHitDis and  canHit then
				findCanHitTarget = entity
				minCanHitDis = dis
			end
		end
	end

	if findCanHitTarget ~= nil then
		return findCanHitTarget
	end
	return findTarget
end

function EntityManager:FindArrowEject(entity)
	local canHitList = {}
	local rangeList = {}
	for go,ejectEntity in pairs(self.go2entity) do
		if ejectEntity ~= entity 
			and ( not ejectEntity:IsDead() )
			and ejectEntity.entityType == entity.entityType then
			local dis = Vector3.Distance(ejectEntity:GetPosition(), entity:GetPosition())
			if dis < 7.5 then
				if LuaGameUtil.GetCanHit(entity, ejectEntity) then
					table.insert(canHitList, ejectEntity)
				end
				table.insert(rangeList, ejectEntity)
			end
		end
	end
	if #canHitList > 0 then
		local r = LuaMath.Random(1, #canHitList)
		return canHitList[r]
	end
	if #rangeList > 0 then
		local r = LuaMath.Random(1, #rangeList)
		return rangeList[r]
	end
end

function EntityManager:GetRoundSelfEntities(entity, range, sameteam)
	local rangeList = {}
	for go,otherEntity in pairs(self.go2entity) do
		if otherEntity ~= entity 
			and ( not otherEntity:IsDead() ) 
			and ( LuaGameUtil.IsSameTeam(entity, otherEntity) == sameteam ) then
			local dis = Vector3.Distance(otherEntity:GetPosition(), entity:GetPosition())
			if dis < range then
				table.insert(rangeList, otherEntity)
			end
		end
	end
	return rangeList
end

function EntityManager:GetNearEntity(entity, range, sameteam)
	local near_min = 10000
	local near_entity = nil
	for go,otherEntity in pairs(self.go2entity) do
		if otherEntity ~= entity
			and (not otherEntity:IsDead() )
			and ( LuaGameUtil.IsSameTeam(entity, otherEntity) == sameteam ) then
			local dis = Vector3.Distance(otherEntity:GetPosition(), entity:GetPosition())
			if dis <= range and (dis < near_min) then
				near_min = dis
				near_entity = otherEntity
			end
		end
	end
	return near_entity
end

function EntityManager:Release()
	self.go2entity = {}
end

return EntityManager
