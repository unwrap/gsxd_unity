
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.ctrl.EntityHitCtrl
--date:2019/10/7 0:22:17
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.entities.ctrl.EntityHitCtrl'
local EntityHitCtrl = lua_declare(strClassName, lua_class(strClassName))

function EntityHitCtrl:ctor(owner)
	self.owner = owner
	self.transform = self.owner.transform
	self.boxCollider = self.owner.gameObject:GetComponent(BoxCollider)
	self.sphereCollider = self.owner.gameObject:GetComponent(SphereCollider)
	self.capsuleCollider = self.owner.gameObject:GetComponent(CapsuleCollider)
end

function EntityHitCtrl:dtor()
	self.owner = nil
	self.transform = nil
	self.boxCollider = nil
	self.sphereCollider = nil
	self.capsuleCollider = nil
end

function EntityHitCtrl:IsColliderTrigger()
	if self.boxCollider ~= nil then
		return self.boxCollider.isTrigger
	end
	if self.capsuleCollider ~= nil then
		return self.capsuleCollider.isTrigger
	end
	if self.sphereCollider ~= nil then
		return self.sphereCollider.isTrigger
	end
	return false
end

function EntityHitCtrl:CastAll(pos)
	local layer = GameUtil.CullingLayer(LayerManager.MapOutWall, LayerManager.Obstruct)
	local move_offset = 0.1
	local dir = pos.normalized
	if self.capsuleCollider ~= nil then
		local center = self.transform:TransformPoint(self.capsuleCollider.center)
		local point1 = center - Vector3.up * self.capsuleCollider.height * 0.5
		local point2 = center + Vector3.up * self.capsuleCollider.height * 0.5
		local radius = self.transform.localScale.x * self.capsuleCollider.radius
		local hitArray = GameUtil.CapsuleCastAll(point1, point2, radius, pos.normalized, pos.magnitude, layer)
		return hitArray
	elseif self.boxCollider ~= nil then
		local center = self.transform:TransformPoint(self.boxCollider.center) - dir * move_offset
		local halfExtents = (self.transform.localScale.x * self.boxCollider.size) * 0.5
		local hitArray = GameUtil.BoxCastAll(center, halfExtents, dir, self.transform.rotation, pos.magnitude + move_offset, layer)
		return hitArray
	elseif self.sphereCollider ~= nil then
		local origin =  self.transform:TransformPoint(self.sphereCollider.center) - dir * move_offset
		local radius = self.transform.localScale.x * self.sphereCollider.radius
		local hitArray = GameUtil.SphereCastAll(origin, radius, dir, pos.magnitude + move_offset, layer)
		return hitArray
	end
	return nil
end

return EntityHitCtrl
