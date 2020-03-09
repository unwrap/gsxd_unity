
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local MoveToTarget = require('game.actions.MoveToTarget')

local strClassName = 'game.brains.monster_fogaman'
local monster_fogaman = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_fogaman:ctor(owner)
    Brain.ctor(self, owner, 'monster_fogaman')
end

function monster_fogaman:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return self.owner:CheckTarget(1.2)
                end,
                SequenceNode(
                {
                    AttackTarget("Attack2"),
                    WaitNode(1),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.8
                    end,
                    MoveToTarget(1.1),
                    WaitNode(1.5)
                )
            ),
        })
    )
end

return monster_fogaman