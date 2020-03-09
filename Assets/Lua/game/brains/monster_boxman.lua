
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local MoveToTarget = require('game.actions.MoveToTarget')

local strClassName = 'game.brains.monster_boxman'
local monster_boxman = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_boxman:ctor(owner)
    Brain.ctor(self, owner, 'monster_boxman')
end

function monster_boxman:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return self.owner:CheckTarget(0.7)
                end,
                SequenceNode(
                {
                    AttackTarget("Attack1"),
                    WaitNode(1),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.65
                    end,
                    MoveToTarget(0.5),
                    WaitNode(1)
                )
            ),
        })
    )
end

return monster_boxman