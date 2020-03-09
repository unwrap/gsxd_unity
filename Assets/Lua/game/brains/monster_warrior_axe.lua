
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local MoveToTarget = require('game.actions.MoveToTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_warrior_axe'
local monster_warrior_axe = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_warrior_axe:ctor(owner)
    Brain.ctor(self, owner, 'monster_warrior_axe')
end

function monster_warrior_axe:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return self.owner:CheckTarget(1.5)
                end,
                SequenceNode(
                {
                    AttackTarget("Attack1"),
                    WaitNode(1),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.7
                    end,
                    MoveToTarget(1.2),
                    IfElseNode(
                        function()
                            return math.random()<0.5
                        end,
                        PatrolTo(1),
                        WaitNode(1)
                    )
                )
            ),
        })
    )
end

return monster_warrior_axe