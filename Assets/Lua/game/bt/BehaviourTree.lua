
---------------------------------------------------------------------------------------------------
--
--filename: game.bt.BehaviourTree
--date:2019/9/29 11:33:01
--author:heguang
--desc:行为树
--
---------------------------------------------------------------------------------------------------
local strClassName = 'BehaviourTree'
local BehaviourTree = lua_declare(strClassName, lua_class(strClassName))

function BehaviourTree:ctor(brain, root)
	self.brain = brain --该行为树的拥有者
	self.root = root --行为树根节点
	self._forceupdate = false --是否强制更新ai

	self.root:SetBrain(brain)
end

function BehaviourTree:dtor()

end

function BehaviourTree:ForceUpdate()
	self._forceupdate = true
end

function BehaviourTree:Update()
	self.root:Visit()
	self.root:SaveStatus()
	self.root:Step()

	self._forceupdate = false
end

function BehaviourTree:Reset()
	self.root:Reset()
end

function BehaviourTree:Stop()
	self.root:Stop()
end

-- 获取整个行为树的睡眠时间 = 所有节点中，最小的那个睡眠时间
-- 如果返回的睡眠时间为空，则该行为树会停止思考，进入休眠状态
-- 如果返回的睡眠时间为0，则表示行为树最终状态不出在运行中，即该行为树本次思考结果要么失败要么成功
function BehaviourTree:GetSleepTime()
	if self._forceupdate then
		return 0
	end
	return self.root:GetTreeSleepTime()
end

return BehaviourTree
