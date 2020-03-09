
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.ctrl.HealthBarCtrl
--date:2019/10/31 0:04:07
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.entities.ctrl.HealthBarCtrl'
local HealthBarCtrl = lua_declare(strClassName, lua_class(strClassName))

function HealthBarCtrl:ctor(owner)
	self.owner = owner
	self:CreateBar()
end

function HealthBarCtrl:SetHP(hp, maxHP)
	if self.slider ~= nil then
		self.slider.value = hp / maxHP
	end
end

function HealthBarCtrl:Remove()
	if self.barObj ~= nil then
		ObjectPool.Recycle(self.barObj)
	end
end

function HealthBarCtrl:CreateBar()
	self.barObj = ObjectPool.Spawn("ui/healthbar.u3d","HealthBar")
    self.bar = self.barObj.transform
    self.bar:SetParent(UIManager.Instance.HUDRoot)
    local p = self.owner:GetTopPosition()
    if p ~= nil then
        local localPos = GameUtil.WorldToUIPoint(p,nil)
        self.bar.position  = localPos
    end
	self.bar.localScale = Vector3.one
    GameUtil.SetLayer(self.bar, LayerManager.UI)

	self.slider = self.barObj:GetComponent(Slider)
	self.slider.value = 1
end

function HealthBarCtrl:Update(deltaTime)
	if self.bar ~= nil then
		local p = self.owner:GetTopPosition()
		if p ~= nil then
			local localPos = GameUtil.WorldToUIPoint(p,nil)
			self.bar.position  = localPos
		end
	end
end

return HealthBarCtrl
