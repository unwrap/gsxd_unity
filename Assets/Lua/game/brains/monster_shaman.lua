
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_shaman'
local monster_shaman = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_shaman:ctor(owner)
    Brain.ctor(self, owner, 'monster_shaman')
end

function monster_shaman:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return math.random()<0.4
                end,
                SequenceNode(
                {
                    AttackTarget("Attack2"),
                    WaitNode(1),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.7
                    end,
                    PatrolTo(2),
                    WaitNode(1)
                )
            ),
        })
    )
end

return monster_shaman