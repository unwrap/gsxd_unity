
---------------------------------------------------------------------------------------------------
--
--filename: game.brains.BrainHero
--date:2019/10/8 9:53:02
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local Brain = require("game.bt.Brain")
require("game.actions.AttackTarget")

local strClassName = 'game.brains.BrainHero'
local BrainHero = lua_declare(strClassName, lua_class(strClassName, Brain))

function BrainHero:ctor(owner)
	Brain.ctor(self, owner, "brain_hero")
end

function BrainHero:dtor()

end

function BrainHero:OnStart()
	local root = PriorityNode({
		AttackTarget("Attack_bow"),
	}, 0)
	self.bt = BehaviourTree(self, root)
end

return BrainHero
