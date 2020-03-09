
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')

local strClassName = 'game.brains.BrainMonster'
local BrainMonster = lua_declare(strClassName, lua_class(strClassName, Brain))

function BrainMonster:ctor(owner)
    Brain.ctor(self, owner, 'BrainMonster')
end

function BrainMonster:OnStart()
    self.bt = BehaviourTree(self, 
        SequenceNode(
        {
            AttackTarget("Attack_bow"),
            WaitNode(2),
        })
    )
end

return BrainMonster