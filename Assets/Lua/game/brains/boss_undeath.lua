
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.boss_undeath'
local boss_undeath = lua_declare(strClassName, lua_class(strClassName, Brain))

function boss_undeath:ctor(owner)
    Brain.ctor(self, owner, 'boss_undeath')
end

function boss_undeath:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfNode(
                function()
                    return math.random()<0.3
                end,
                SequenceNode(
                {
                    AttackTarget("Attack2"),
                    WaitNode(1),
                })
            ),
            IfNode(
                function()
                    return math.random()<0.3
                end,
                SequenceNode(
                {
                    AttackTarget("Attack3"),
                    WaitNode(1),
                })
            ),
            IfElseNode(
                function()
                    return math.random()<0.7
                end,
                PatrolTo(2),
                WaitNode(2)
            ),
        })
    )
end

return boss_undeath