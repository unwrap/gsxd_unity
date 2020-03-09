
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.boss_king'
local boss_king = lua_declare(strClassName, lua_class(strClassName, Brain))

function boss_king:ctor(owner)
    Brain.ctor(self, owner, 'boss_king')
end

function boss_king:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfNode(
                function()
                    return math.random()<0.3
                end,
                SequenceNode(
                {
                    AttackTarget("Attack1"),
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

return boss_king