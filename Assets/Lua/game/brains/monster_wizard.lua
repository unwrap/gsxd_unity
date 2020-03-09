
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_wizard'
local monster_wizard = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_wizard:ctor(owner)
    Brain.ctor(self, owner, 'monster_wizard')
end

function monster_wizard:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return math.random()<0.5
                end,
                SequenceNode(
                {
                    AttackTarget("Attack3"),
                    WaitNode(1),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.7
                    end,
                    PatrolTo(1.8),
                    WaitNode(2)
                )
            ),
        })
    )
end

return monster_wizard