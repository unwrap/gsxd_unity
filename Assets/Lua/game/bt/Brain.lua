
---------------------------------------------------------------------------------------------------
--
--filename: game.bt.Brain
--date:2019/9/29 11:15:17
--author:heguang
--desc:大脑，ai的封装
--
---------------------------------------------------------------------------------------------------
require("game.bt.BehaviourNode")

local strClassName = 'game.bt.Brain'
local Brain = lua_declare(strClassName, lua_class(strClassName))

local math_random = math.random
local math_floor = math.floor

function Brain:ctor(owner, name)
	self.owner = owner
	self.aiName = name
	self.bt = nil --大脑的行为树

	self.sleepTime = 0
end

function Brain:dtor()

end

function Brain:GetOwner()
	return self.owner
end

function Brain:IsValid()
	local owner = self.owner
	if not owner or not owner:IsValid() or owner:IsDead() then
		return false
	end
	return true
end

--行为树强制update一次
function Brain:ForceUpdate()

end

function Brain:GetSleepTime()
	if self.bt then
		return self.bt:GetSleepTime()
	end
	return 0
end

function Brain:Start()
	if not self:IsValid() then
		return
	end
	--创建行为树bt，由具体的子类重写(必须要实现该方法)
	self:OnStart()
	--行为树的初始化，由具体的子类重写
	if self.OnInit then
		self:OnInit()
	end
end

function Brain:Update()
	if self.sleepTime > 0 then
		self.sleepTime = self.sleepTime - Time.deltaTime
		return
	end

	if self.DoUpate then
		self:DoUpate()
	end

	if self.bt then
		self.bt:Update()
	end

	if self.OnUpdate then
		self:OnUpdate()
	end

	self.sleepTime = self:GetSleepTime()
end

function Brain:Stop()
	if self.bt then
		self.bt:Stop()
	end
end

return Brain
