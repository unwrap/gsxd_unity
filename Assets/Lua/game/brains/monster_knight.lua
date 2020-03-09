
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local MoveToTarget = require('game.actions.MoveToTarget')

local strClassName = 'game.brains.monster_knight'
local monster_knight = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_knight:ctor(owner)
    Brain.ctor(self, owner, 'monster_knight')
end

function monster_knight:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return self.owner:CheckTarget(0.94)
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
                    MoveToTarget(0.9),
                    WaitNode(1.5)
                )
            ),
        })
    )
end

return monster_knight