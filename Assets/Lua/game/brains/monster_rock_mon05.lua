
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_rock_mon05'
local monster_rock_mon05 = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_rock_mon05:ctor(owner)
    Brain.ctor(self, owner, 'monster_rock_mon05')
end

function monster_rock_mon05:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return math.random()<0.3
                end,
                SequenceNode(
                {
                    AttackTarget("Attack4"),
                    WaitNode(2),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.7
                    end,
                    PatrolTo(1),
                    WaitNode(2)
                )
            ),
        })
    )
end

return monster_rock_mon05