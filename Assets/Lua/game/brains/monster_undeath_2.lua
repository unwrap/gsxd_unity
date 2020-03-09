
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_undeath_2'
local monster_undeath_2 = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_undeath_2:ctor(owner)
    Brain.ctor(self, owner, 'monster_undeath_2')
end

function monster_undeath_2:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return math.random()<0.4
                end,
                SequenceNode(
                {
                    AttackTarget("Attack2"),
                    WaitNode(2),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.7
                    end,
                    PatrolTo(1.6),
                    WaitNode(2)
                )
            ),
        })
    )
end

return monster_undeath_2