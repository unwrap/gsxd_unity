
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')

local strClassName = 'game.brains.monster_2_attack'
local monster_2_attack = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_2_attack:ctor(owner)
    Brain.ctor(self, owner, 'monster_2_attack')
end

function monster_2_attack:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            AttackTarget("Attack4"),
        })
    )
end

return monster_2_attack