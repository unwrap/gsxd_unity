
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local MoveToTarget = require('game.actions.MoveToTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_zombie'
local monster_zombie = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_zombie:ctor(owner)
    Brain.ctor(self, owner, 'monster_zombie')
end

function monster_zombie:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return self.owner:CheckTarget(1.5)
                end,
                SequenceNode(
                {
                    AttackTarget("Attack4"),
                    WaitNode(3),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.75
                    end,
                    MoveToTarget(1.2),
                    IfElseNode(
                        function()
                            return math.random()<0.5
                        end,
                        PatrolTo(1),
                        WaitNode(2)
                    )
                )
            ),
        })
    )
end

return monster_zombie