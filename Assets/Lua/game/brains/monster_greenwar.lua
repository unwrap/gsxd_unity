
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local MoveToTarget = require('game.actions.MoveToTarget')

local strClassName = 'game.brains.monster_greenwar'
local monster_greenwar = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_greenwar:ctor(owner)
    Brain.ctor(self, owner, 'monster_greenwar')
end

function monster_greenwar:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfNode(
                function()
                    return self.owner:CheckTarget(1.5)
                end,
                SequenceNode(
                {
                    AttackTarget("Attack1"),
                    WaitNode(1),
                })
            ),
            IfNode(
                function()
                    return self.owner:CheckTarget(2)
                end,
                SequenceNode(
                {
                    AttackTarget("Attack3"),
                    WaitNode(1),
                })
            ),
            IfElseNode(
                function()
                    return math.random()<0.8
                end,
                MoveToTarget(1.1),
                WaitNode(1)
            ),
        })
    )
end

return monster_greenwar