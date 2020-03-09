
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_radish_mon3'
local monster_radish_mon3 = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_radish_mon3:ctor(owner)
    Brain.ctor(self, owner, 'monster_radish_mon3')
end

function monster_radish_mon3:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return math.random()<0.3
                end,
                SequenceNode(
                {
                    AttackTarget("Attack_jump"),
                    WaitNode(1),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.7
                    end,
                    PatrolTo(2),
                    WaitNode(2)
                )
            ),
        })
    )
end

return monster_radish_mon3