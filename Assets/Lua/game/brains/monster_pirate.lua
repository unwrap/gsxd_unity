
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_pirate'
local monster_pirate = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_pirate:ctor(owner)
    Brain.ctor(self, owner, 'monster_pirate')
end

function monster_pirate:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return math.random()<0.5
                end,
                SequenceNode(
                {
                    AttackTarget("Attack_gun"),
                    WaitNode(1),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.7
                    end,
                    PatrolTo(3),
                    WaitNode(1)
                )
            ),
        })
    )
end

return monster_pirate