
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local MoveToTarget = require('game.actions.MoveToTarget')

local strClassName = 'game.brains.monster_police'
local monster_police = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_police:ctor(owner)
    Brain.ctor(self, owner, 'monster_police')
end

function monster_police:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return self.owner:CheckTarget(0.9)
                end,
                SequenceNode(
                {
                    AttackTarget("Attack2"),
                    WaitNode(1),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.85
                    end,
                    MoveToTarget(0.8),
                    WaitNode(3)
                )
            ),
        })
    )
end

return monster_police