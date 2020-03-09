
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_sparcher'
local monster_sparcher = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_sparcher:ctor(owner)
    Brain.ctor(self, owner, 'monster_sparcher')
end

function monster_sparcher:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return math.random()<0.3
                end,
                SequenceNode(
                {
                    AttackTarget("Attack_bow"),
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

return monster_sparcher