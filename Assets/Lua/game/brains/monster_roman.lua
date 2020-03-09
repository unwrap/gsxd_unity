
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local MoveToTarget = require('game.actions.MoveToTarget')

local strClassName = 'game.brains.monster_roman'
local monster_roman = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_roman:ctor(owner)
    Brain.ctor(self, owner, 'monster_roman')
end

function monster_roman:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return self.owner:CheckTarget(2)
                end,
                SequenceNode(
                {
                    AttackTarget("Attack3"),
                    WaitNode(1),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.85
                    end,
                    MoveToTarget(1.8),
                    WaitNode(2)
                )
            ),
        })
    )
end

return monster_roman