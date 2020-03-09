
---------------------------------------------------------------------------------------------------
--
--filename: game.bt.BehaviourNode
--date:2019/9/29 11:33:11
--author:heguang
--desc:行为树各类节点
--[[
行为树节点主要分为：
1、组合节点（序列节点、选择节点、并行节点等）
2、装饰节点（且只能有一个子节点）
3、条件节点
4、动作节点

只有条件节点和动作节点能做完行为树的叶子节点，
而组合、装饰节点控制行为树的决策走向，所以，
条件和动作节点称为行为节点（Behavior Node），
组合和装饰节点称为决策节点（Decider Node）。

只有叶子节点才需要特别定制。
--]]
--
---------------------------------------------------------------------------------------------------
require("game.bt.BehaviourTree")

---------------------------------------------------------------------------------------------------
--行为树节点父类
local BehaviourNode = lua_declare("BehaviourNode", lua_class("BehaviourNode"))

local BT = BehaviourNode
BT.READY = "READY"		--准备
BT.SUCCESS = "SUCCESS"	--成功
BT.FAILED = "FAILED"	--失败
BT.RUNNING = "RUNNING"	--运行中

function BehaviourNode:ctor(children, need)
	self.children = children
	self.needBrain = need

	self.kind = "BehaviourNode"
	self.owner = nil
	self.status = BT.READY
	self.lastresult = BT.READY
	self.nextUpdateTime = nil

	if children then
		for _,child in ipairs(children) do
			child.parent = self
		end
	end
end

function BehaviourNode:dtor()

end

function BehaviourNode:SetBrain(brain)
	if self.needBrain then
		self.brain = brain
		if self.OnSetBrain then
			self:OnSetBrain()
		end
	end
	if self.children then
		for k, child in ipairs(self.children) do
			child:SetBrain(brain)
		end
	end
end

function BehaviourNode:GetBrain()
	return self.brain
end

function BehaviourNode:GetOwner()
	local brain = self:GetBrain()
	if brain then
		return brain:GetOwner()
	end
end

function BehaviourNode:IsKindOf(k)
	return self.kind == k
end

-- 从当前节点的父节点开始往上执行func函数
function BehaviourNode:DoToParents(func)
	if self.parent then
		func(self.parent)
		return self.parent:DoToParents(func)
	end
end

function BehaviourNode:Sleep(t)
	self.nextUpdateTime = Time.realtimeSinceStartup + t
end

function BehaviourNode:GetSleepTime()
	if self.status == BT.RUNNING
		and not self.children
		and not self:IsKindOf("ConditionNode") then
		if self.nextUpdateTime then
			local timeTo = self.nextUpdateTime - Time.realtimeSinceStartup
			if timeTo > 0 then
				return timeTo
			end
		end
		return 0
	end
end

-- 获取从该节点开始（包括该节点），最小的睡眠时间
function BehaviourNode:GetTreeSleepTime()
	local sleepTime = 0
	if self.children then
		for _,child in ipairs(self.children) do
			if child.status == BT.RUNNING then
				local t = child:GetTreeSleepTime()
				if t and (not sleepTime or t < sleepTime) then
					sleepTime = t
				end
			end
		end
	end
	local myTime = self:GetSleepTime()
	if myTime and (not sleepTime or myTime < sleepTime) then
		sleepTime = myTime
	end
	return sleepTime
end

function BehaviourNode:ToString()
	return ""
end

function BehaviourNode:GetString()
	local str = ""
	if self.status == BT.RUNNING then
		str = self:ToString()
	end
	if #str > 0 then
		return string.format([[%s:[%s-->%s]:(%s)]], self.kind, self.lastresult or "?", self.status or "UNKNOW", str)
	else
		return string.format("%s:[%s-->%s]", self.kind, self.lastresult or "?", self.status or "UNKNOW")
	end
end

function BehaviourNode:GetTreeString(indent)
	indent = indent or ""
	local str
	local sleepTime = self:GetTreeSleepTime()
	if sleepTime then
		str = string.format("%s├─%s sleep:[%s]\n", indent, self:GetString(), sleepTime)
	else
		str = string.format("%s├─%s\n", indent, self:GetString())
	end
	if self.children then
		local isNotLast
		if self.parent and self.parent.children then
			local l = #self.parent.children
			isNotLast = self.parent.children[l] ~= self
		end
		indent = indent .. (isNotLast and "│  " or "   ")
		for _,child in ipairs(self.children) do
			str = str .. child:GetTreeSleepTime(indent)
		end
	end
	return str
end

function BehaviourNode:Visit()
	self.status = BT.FAILED
end

function BehaviourNode:SaveStatus()
	self.lastresult = self.status
	if self.children then
		for k,v in pairs(self.children) do
			v:SaveStatus()
		end
	end
end

function BehaviourNode:Step()
	if self.status ~= BT.RUNNING then
		self:Reset()
	elseif self.children then
		for k,v in ipairs(self.children) do
			v:Step()
		end
	end
end

function BehaviourNode:Reset()
	if self.status ~= BT.READY then
		self.status = BT.READY
		if self.children then
			for _,child in ipairs(self.children) do
				child:Reset()
			end
		end
	end
end

function BehaviourNode:Stop()
	if self.OnStop then
		self:OnStop()
	end
	if self.children then
		for _,child in ipairs(self.children) do
			child:Stop()
		end
	end
end

---------------------------------------------------------------------------------------------------
--装饰节点
--[[
它将它的子节点执行后返回的结果做额外处理后，再返回给它的父节点，装饰节点作为控制分支节点，必须且只接受一个子节点。
装饰节点的执行首先执行子节点，并根据自身的控制逻辑以及子节点的返回结果决定自身的状态。
主要包括：
loop 节点
not 节点
--]]
local DecoratorNode = lua_declare("DecoratorNode", lua_class("DecoratorNode", BehaviourNode))

function DecoratorNode:ctor(child)
	BehaviourNode.ctor(self, {child})
	self.kind = "DecoratorNode"
end

-- not装饰节点
--[[
类似于逻辑"非"操作，非节点对子节点的返回值执行取反操作。
如果子节点状态为running,则将自身状态也设置为running,其它状态则取反
--]]
local NotDecorator = lua_declare("NotDecorator", lua_class("NotDecorator", DecoratorNode))

function NotDecorator:ctor(child)
	DecoratorNode.ctor(self, child)
	self.kind = "NotDecorator"
end

function NotDecorator:Visit()
	local child = self.children[1]
	child:Visit()

	local status = child.status
	if status == BT.SUCCESS then
		self.status = BT.FAILED
	elseif status == BT.FAILED then
		self.status = BT.SUCCESS
	else
		self.status = status
	end
end

-- time节点
--[[
该节点的状态由子节点决定
当子节点的返回状态为成功(success),则更新该节点的nextTime,否则，下一次visit继续尝试执行子节点
该节点实现的逻辑：每隔一段时间尝试执行一次子节点，如果子节点返回成功，则继续下一次等待。
any = true 表示无论子节点是否成功，都重置下一次执行时间
--]]

local TimeDecorator = lua_declare("TimeDecorator", lua_class("TimeDecorator", DecoratorNode))

function TimeDecorator:ctor(wt, child, any)
	DecoratorNode.ctor(self, child)
	self.kind = "TimeDecorator"

	self.nextTime = 0 --下一次执行的时间戳
	self.waitTime = wt
	self.any = any
end

function TimeDecorator:Visit()
	local ctm = Time.realtimeSinceStartup
	if self.status == BT.RUNNING or ctm >= self.nextTime then
		local child = self.children[1]
		child:Visit()
		self.status = child.status
	end
	if self.any then
		if self.status == BT.SUCCESS or self.status == BT.FAILED then
			self.nextTime = ctm + self.waitTime
		end
	else
		if self.status == BT.SUCCESS then
			self.nextTime = ctm + self.waitTime
		end
	end
end

---------------------------------------------------------------------------------------------------
--条件节点
--[[
条件节点根据比较结果返回成功或失败，但永远不会返回正在执行(running)
--]]
local ConditionNode = lua_declare("ConditionNode", lua_class("ConditionNode", BehaviourNode))

function ConditionNode:ctor(func)
	BehaviourNode.ctor(self)
	self.kind = "ConditionNode"
	self.fn = func
end

--条件为true则返回成功
function ConditionNode:Visit()
	if self.fn and self.fn() then
		self.status = BT.SUCCESS
	else
		self.status = BT.FAILED
	end
end

-- 条件等待节点
local ConditionWaitNode = lua_declare("ConditionWaitNode", lua_class("ConditionWaitNode", BehaviourNode))

function ConditionWaitNode:ctor(func)
	BehaviourNode.ctor(self)
	self.kind = "ConditionWaitNode"
	self.fn = func
end

-- 和条件节点不一样的地方是：原来判断为失败的情况，现在判断为running
function ConditionWaitNode:Visit()
	if self.fn and self.fn() then
		self.status = BT.SUCCESS
	else
		self.status = BT.RUNNING
	end
end

---------------------------------------------------------------------------------------------------
--动作节点
--通常对应owner的某个方法，一般是个瞬间动作，如放个技能，说一句话等
--如果是持续性动作，比如移动到某个点，需要用到bufferAction
local ActionNode = lua_declare("ActionNode", lua_class("ActionNode", BehaviourNode))

function ActionNode:ctor(action, resetFn)
	BehaviourNode.ctor(self)
	self.kind = "ActionNode"
	self.action = action
	self.resetFn = resetFn
end

function ActionNode:Reset()
	ActionNode.super.Reset(self)
	if self.resetFn then
		self.resetFn()
	end
end

function ActionNode:Visit()
	if self.action then
		self.action()
	end
	self.status = BT.SUCCESS
end

-- ActionDrtNode ，ActionNode装饰节点
-- 根据action的返回结果，决定该节点的状态

local ActionDrtNode = lua_declare("ActionDrtNode", lua_class("ActionDrtNode", ActionNode))

function ActionDrtNode:ctor(action, resetFn)
	ActionNode.ctor(self, action, resetFn)
	self.kind = "ActionDrtNode"
end

function ActionDrtNode:Visit()
	local ok = self.action()
	if ok then
		self.status = BT.SUCCESS
	else
		self.status = BT.FAILED
	end
end

---------------------------------------------------------------------------------------------------
--组合节点

-- 序列节点
--[[
它实现的是and逻辑，例如：r = x and y and z，则先执行x，如果x为true，则继续执行y，如果x为false，则直接返回false，以此类推
执行该节点时，它会一个接一个执行
如果子节点状态为success，则执行下一个节点
如果子节点状态为running，则把自身设置为running，并等待返回其它结果(success或false)
如果子节点状态为failed，则把自身设置为failed，并返回
如果所有节点都为success，则把自身设置为success并返回
原则：只要一个节点返回"失败"或"运行中"，则返回；若返回"成功"，则执行下一个子节点
--]]

local SequenceNode = lua_declare("SequenceNode", lua_class("SequenceNode", BehaviourNode))

function SequenceNode:ctor(children)
	BehaviourNode.ctor(self, children)
	self.kind = "SequenceNode"
	self.idx = 1 --正在运行的是第几个子节点
end

function SequenceNode:Visit()
	if self.status ~= BT.RUNNING then --如果没有运行的子节点，则从头开始执行
		self.idx = 1
	end
	local count = #self.children
	local child
	local status
	while self.idx <= count do
		child = self.children[self.idx]
		child:Visit()
		status = child.status
		if status == BT.RUNNING or status == BT.FAILED then
			self.status = status
			return
		end
		self.idx = self.idx + 1
	end
	self.status = BT.SUCCESS --所有子节点都返回success
end

function SequenceNode:Reset()
	self.idx = 1
	SequenceNode.super.Reset(self)
end

function SequenceNode:ToString()
	return tostring(self.idx)
end

-- 选择节点
--[[
它实现的是or的逻辑，例如：r = x or y or z,则先执行x，如果x为false，则继续执行y，如果x为true，则直接返回true，以此类推
执行该节点时，它会一个接一个运行，
如果子节点状态为success，则把自身设置为success并返回；
如果子节点状态为running，则把自身设置为running，并等待返回其他结果（success或failed）；
如果子节点状态为failed，则会执行下一个子节点；
如果所有没子节点都不为success，则把自身设置为failed并返回。
原则：只要一个子节点返回"成功"或"运行中"，则返回；若返回"失败"，则执行下一个子节点。
--]]

local SelectorNode = lua_declare("SelectorNode", lua_class("SelectorNode", BehaviourNode))

function SelectorNode:ctor(children)
	BehaviourNode.ctor(self, children)
	self.kind = "SelectorNode"
	self.idx = 1
end

function SelectorNode:Visit()
	if self.status ~= BT.RUNNING then
		self.idx = 1
	end
	local count = #self.children
	local child
	local status
	while self.idx <= count do
		child = self.children[self.idx]
		child:Visit()
		status = child.status
		if status == BT.SUCCESS or status == BT.RUNNING then
			self.status = status
			return
		end
		self.idx = self.idx + 1
	end
	self.status = BT.FAILED
end

function SelectorNode:Reset()
	self.idx = 1
	SelectorNode.super.Reset(self)
end

function SelectorNode:ToString()
	return tostring(self.idx)
end

-- 并行节点
--[[
看上去是同时执行所有的子节点，但是真正的逻辑还是一个一个执行子节点。
如果子节点的状态是failed，则将自身设置为failed，并返回；
如果子节点是success或者running，则运行下一个子节点；
如果所有子节点都为success，则将自身设置为success并返回，否则设置自身为running。
在运行到该节点时，要对部分节点(ConditionNode、NotDecorator)做重置，重启判断。
ps:这里的实现的其实是Parallel Sequence Node，如果子节点failed,则返回。
并行节点可以设置退出条件，参考：
http://www.cnblogs.com/hammerc/p/5044815.html
--]]

local ParallelNode = lua_declare("ParallelNode", lua_class("ParallelNode", BehaviourNode))

function ParallelNode:ctor(children)
	BehaviourNode.ctor(self)
	self.kind = "ParallelNode"
	self.stoponanycomplete = nil --只要有一个子节点返回成功，则该并行节点退出，并返回成功
end

function ParallelNode:Visit()
	local done = true --是否所有子节点都success
	local any_done = false
	for _,child in ipairs(self.children) do
		if child:IsKindOf("ConditionNode") then --重启条件节点
			child:Reset()
		end
		if child.status ~= BT.SUCCESS then
			child:Visit()
			if child.status == BT.FAILED then
				self.status = BT.FAILED
				return
			end
		end
		if child.status == BT.RUNNING then
			done = false
		else
			any_done = true
		end
	end
	if done or (self.stoponanycomplete and any_done) then
		self.status = BT.SUCCESS
	else
		self.status = BT.RUNNING
	end
end

-- 并行节点如果不在"运行中"，则重置条件子节点
function ParallelNode:Step()
	if self.status ~= BT.RUNNING then
		self:Reset()
	else
		--只重置条件子节点
		if self.children then
			for _,child in ipairs(self.children) do
				if self:IsKindOf("ConditionNode")
					and child.status == BT.SUCCESS then
					child:Reset()
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------
--组合扩展节点

--while节点
--[[
实现了while操作，ParallelNode的扩展
直到条件不满足，则停止该节点
注意：while节点的每一次思考，都会重启条件节点的判断，这与if节点不同。
--]]
local WhileNode = lua_declare("WhileNode", lua_class("WhileNode", ParallelNode))

function WhileNode:ctor(condFunc, node)
	local condNode = ConditionNode(condFunc)
	ParallelNode.ctor(self, {condNode, node})
	self.kind = "WhileNode"
end

--if 节点
--[[
实现了if操作，只有cond为success时，node才会被执行
注意：如果node处于运行中，则会在下一次思考时，继续执行node节点，直到node返回成功或失败，该节点才会退出
如果node节点有可能出现运行中状态，则该节点不适用
因为如果running，那么下一次think时，会跳过条件检查，直接从running的node节点开始执行
--]]
local IfNode = lua_declare("IfNode", lua_class("IfNode", SequenceNode))

function IfNode:ctor(condFunc, node)
	local children = {ConditionNode(condFunc), node}
	SequenceNode.ctor(self, children)
	self.kind = "IfNode"
end

-- ParallelNodeAny
--[[
ParallelNode的扩展节点，唯一不同的地方是：
只要执行的子节点状态为success时，则会将自己设置为success并返回。
当然，并行节点还是会将所有节点都执行一遍。
--]]
local ParallelNodeAny = lua_declare("ParallelNodeAny", lua_class("ParallelNodeAny", ParallelNode))

function ParallelNodeAny:ctor(children)
	ParallelNode.ctor(self, children)
	self.stoponanycomplete = true -- 只要子节点有一个是success状态，则并行节点状态也为success状态
	self.kind = "ParallelNodeAny"
end

-- ifelse 节点
-- 实现if else 的逻辑
local IfElseNode = lua_declare("IfElseNode", lua_class("IfElseNode", BehaviourNode))

function IfElseNode:ctor(condFunc, okNode, elseNode)
	BehaviourNode.ctor(self, {ConditionNode(condFunc), okNode, elseNode})
	self.kind = "IfElseNode"
end

function IfElseNode:Reset()
	self.idx = 1
	IfElseNode.super.Reset(self)
end

function IfElseNode:Visit()
	if self.status ~= BT.RUNNING then
		self.idx = 1
		local condNode = self.children[1]
		condNode:Visit()
		local condStatus = condNode.status
		if condStatus == BT.SUCCESS then
			self.idx = 2
		elseif condStatus == BT.FAILED then
			self.idx = 3
		end
	end

	local child = self.children[self.idx]
	child:Visit()
	self.status = child.status
end

---------------------------------------------------------------------------------------------------
--其他节点

--等待节点
--[[
从ai开始执行到该节点开始，到结束时间都为running，在等待时间结束后，节点状态改为success
只会返回成功或运行中
--]]
local WaitNode = lua_declare("WaitNode", lua_class("WaitNode", BehaviourNode))

function WaitNode:ctor(time)
	BehaviourNode.ctor(self)
	self.kind = "WaitNode"
	self.waitTime = time --等待时间间隔(ms)
	self.wakeTime = nil --唤醒时间
end

function WaitNode:ToString()
	local w = self.wakeTime - Time.realtimeSinceStartup
	return string.format("%.f", w)
end

function WaitNode:Visit()
	local ctm = Time.realtimeSinceStartup
	if self.status ~= BT.RUNNING then
		self.wakeTime = ctm + self.waitTime
		self.status = BT.RUNNING
	end

	if self.status == BT.RUNNING then
		if self.wakeTime > ctm then
			self:Sleep(self.wakeTime - ctm)
		else
			self.status = BT.SUCCESS
		end
	end
end

-- loop节点
--[[
逻辑类似序列节点（SequenceNode），会一个接一个执行子节点。
如果子节点的状态为running，则阻止下一个节点的运行，下一次再次执行该节点时，会继续从running的子节点开始；
如果子节点的状态为faile，则将自身设置为failed并返回；
如果循环次数已满，则设置自身状态为success并返回。
--]]

local LoopNode = lua_declare("LoopNode", lua_class("LoopNode", BehaviourNode))

function LoopNode:ctor(children, maxreps, maxrepFn)
	BehaviourNode.ctor(self, children)
	self.kind = "LoopNode"
	self.idx = 1                              --执行到第几个子节点了
	self.maxreps = maxreps or 0  --最大循环次数
	self.rep = 0                              --当前循环到第几次了
	self.fn = maxrepFn                  --用来动态设置最大循环次数
end

function LoopNode:ToString()
	return tostring(self.idx)
end

function LoopNode:Reset()
	LoopNode.super.Reset(self)
	self.idx = 1
	self.rep = 0
end

function LoopNode:Visit()
	if self.status ~= BT.RUNNING then --如果执行该节点时，不为running则重置
		self.idx = 1
		self.rep = 0
		self.status = BT.RUNNING
		if self.fn then
			local n = self.fn(self)
			if n and type(n) == "number" then
				self.maxreps = math.floor(n)
			else
				self.maxreps = 0
			end
		end
	end

	--直接返回成功
	if self.maxreps <= 0 then
		self.status = BT.SUCCESS
		return
	end

	local done = false
	local count = #self.children
	local childStatus
	while self.idx <= count do
		local child = self.children[self.idx]
		child:Visit()
		childStatus = child.status
		if childStatus == BT.RUNNING or childStatus == BT.FAILED then
			self.status = childStatus
			return
		end
		self.idx = self.idx + 1
	end

	self.idx = 1 --一次loop完毕
	self.rep = self.rep + 1 --loop次数+1
	if self.rep >= self.maxreps then
		self.status = BT.SUCCESS
	else
		for _,v in ipairs(self.children) do
			v:Reset()
		end
	end
end

---------------------------------------------------------------------------------------------------
-- 优先级节点（等价于：优先选择节点）
-- 顺序执行子节点，如果子节点返回成功或运行中，记录该子节点，并将其他子节点重置
local PriorityNode = lua_declare("PriorityNode", lua_class("PriorityNode", BehaviourNode))

function PriorityNode:ctor(children, period)
	BehaviourNode.ctor(self, children)
	self.kind = "PriorityNode"
	self.period = period or 1 --行为树执行的周期
	self.lastTime = 0
	self.idx = nil
	self.doEval = false
end

function PriorityNode:ToString()
	local time_till = 0
	if self.period then
		time_till = (self.lastTime or 0) + self.period - Time.realtimeSinceStartup
	end
	return string.format("idx=%d,eval=%d", self.idx or -1, time_till)
end

function PriorityNode:GetSleepTime()
	if not self.period then
		return 0
	end

	local timeTo = 0 --到期时间
	if self.lastTime then
		timeTo = (self.lastTime + self.period) - Time.realtimeSinceStartup
		if timeTo < 0 then
			timeTo = 0
		end
	end

	if self.status then
		return timeTo
	end

	return nil
end

function PriorityNode:Reset()
	PriorityNode.super.Reset(self)
	self.idx = nil
end

function PriorityNode:Visit()
	local ctm = Time.realtimeSinceStartup
	local do_eval = not self.lastTime or self.lastTime + self.period < ctm

	self.doEval = do_eval
	if do_eval then --从头开始评估(执行)子节点（这里相当于定时器，每隔self._period就执行一次）
		local old_event = nil
		local eventChild = self.idx and self.children[self.idx]
		if eventChild and eventChild:IsKindOf("EventNode") then
			old_event = eventChild
		end
		self.lastTime = ctm
		local found = false --找到第一个返回成功或运行中的子节点
		for idx, child in ipairs(self.children) do
			local should_test_anyway = old_event and child:IsKindOf("EventNode") and old_event.priority <= child.priority
			if not found or should_test_anyway then
				if child.status == BT.FAILED or child.status == BT.SUCCESS then
					child:Reset()
				end

				child:Visit()
				local cs = child.status
				if cs == BT.SUCCESS or cs == BT.RUNNING then
					if should_test_anyway and self.idx ~= idx then
						self.children[self.idx]:Reset()
					end
					found = true
					self.status = cs
					self.idx = idx
				end
			else
				child:Reset()
			end
		end
		if not found then
			self.status = BT.FAILED
		end
	else
		if self.idx then
			local child = self.children[self.idx]
			if child.status == BT.RUNNING then
				child:Visit()
				self.status = child.status
				if self.status ~= BT.RUNNING then
					self.lastTime = nil
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------
--事件节点
local EventNode = lua_declare("EventNode", lua_class("EventNode", BehaviourNode))

function EventNode:ctor(event, child, priority)
	assert(event)
	BehaviourNode.ctor(self, {child}, true)
	self.event = event
	self.priority = priority or 0 --优先级 
	self.triggered = false
	self.data = nil
	self.kind = "EventNode"
end

function EventNode:OnSetBrain()
	if self.event then
		local owner = self:GetOwner()
		if owner then
			owner:AddEventListener(self.event, self.OnEvent, self)
		end
	end
end

function EventNode:OnStop()
	if self.event then
		local owner = self:GetOwner()
		if owner then
			owner:RemoveEventListener(self.event, self.OnEvent)
		end
	end
end

function EventNode:OnEvent(data)
	if self.status == BT.RUNNING then
		self.children[1]:Reset()
	end

	self.triggered = true
	self.data = data

	if self.brain then
		self:DoToParents(function(node)
			if node:IsKindOf("PriorityNode") then
				node.lastTime = nil --让PriorityNode从头执行
			end
		end)
		self.brain:ForceUpdate()
	end
end

function EventNode:Step()
	EventNode.super.Step(self)
	self.triggered = false
end

function EventNode:Reset()
	EventNode.super.Reset(self)
	self.triggered = false
end

function EventNode:Visit()
	if self.status == BT.READY and self.triggered then
		self.status = BT.RUNNING
	end
	if self.status == BT.RUNNING then
		if self.children and #self.children == 1 then
			local child = self.children[1]
			child:Visit()
			self.status = child.status
		else
			self.status = BT.FAILED
		end
	end
end
