
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.ctrl.EntityLineCtrl
--date:2019/12/3 21:12:58
--author:heguang
--desc:攻击预警线
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.entities.ctrl.EntityLineCtrl'
local EntityLineCtrl = lua_declare(strClassName, lua_class(strClassName))

function EntityLineCtrl:ctor(owner)
	self.owner = owner
	self.isShow = false

	self.raycastLayer = GameUtil.CullingLayer(LayerManager.MapOutWall, LayerManager.Obstruct)
	self.reboundNum = 2
	self.lineWidth = 0.5
end

function EntityLineCtrl:OnDestroy()
	self:Hide()
end

function EntityLineCtrl:Show(rebound)
	if self.isShow then
		return
	end
	if rebound == nil then
		rebound = 1
	end
	self.reboundNum = rebound
	self.lineObjs = {}
	for i=1,self.reboundNum do
		local lineObj = ObjectPool.Spawn(LuaGameUtil.GetEffectAbName("entityline"))
		local lineRender = GameUtil.GetComponent(lineObj, LineRenderer)
		local lineMaterial = lineRender.material
		table.insert(self.lineObjs, {lineObj, lineRender, lineMaterial})
	end
	self:Update(0)
	self.isShow = true
end

function EntityLineCtrl:Hide()
	if not self.isShow then
		return
	end
	self.isShow = false
	for i=1,#self.lineObjs do
		local lineObj = self.lineObjs[i]
		local lineRender = lineObj[2]
		if not Slua.IsNull(lineRender) then
			lineRender.positionCount = 0
		end
		ObjectPool.Recycle(lineObj[1])
	end
	self.lineObjs = nil
end

function EntityLineCtrl:SetWidth(val)
	self.lineWidth = val
end

function EntityLineCtrl:Update(deltaTime)
	if not self.isShow then
		return
	end

	local raycastOrigin = self.owner:GetEffectPoint()
	if raycastOrigin.y < 0.1 then
		raycastOrigin.y = 0.1
	end
	local rayDir = self.owner.transform.forward
	local linePositions = {raycastOrigin}
	for i=1,self.reboundNum do
		local triggerHits = GameUtil.Raycast(raycastOrigin, rayDir, 100, self.raycastLayer)
		if triggerHits ~= nil then
			local minRayhit = nil
			local minDistance = 1000
			for i=1, #triggerHits do
				local hit = triggerHits[i]
				if hit.collider ~= nil and hit.collider.gameObject ~= nil then
					local hitObj = hit.collider.gameObject
					if hitObj ~= self.owner.gameObject and hitObj ~= self.gameObject then
						if hit.distance <= minDistance then
							minDistance = hit.distance
							minRayhit = hit
						end
					end
				end
			end
			if minRayhit ~= nil then
				raycastOrigin = minRayhit.point
				table.insert(linePositions, raycastOrigin)
				rayDir = Vector3.Reflect(rayDir, minRayhit.normal)
			else
				table.insert(linePositions, raycastOrigin)
			end
		else
			table.insert(linePositions, raycastOrigin)
		end
	end

	for i=1,self.reboundNum do
		local obj = self.lineObjs[i]
		local lineRender = obj[2]
		lineRender.positionCount = 2
		lineRender:SetPosition(0, linePositions[i])
		lineRender:SetPosition(1, linePositions[i+1])
		lineRender.startWidth = self.lineWidth
		lineRender.endWidth = self.lineWidth

		local lineMaterial = obj[3]
		local lineLength = Vector3.Distance(linePositions[i], linePositions[i+1])
		lineMaterial.mainTextureScale = Vector2(lineLength/3, 1)
		local offset = lineMaterial.mainTextureOffset
		lineMaterial.mainTextureOffset = offset - Vector2(Time.deltaTime * 0.5, 0)
	end
end

return EntityLineCtrl
