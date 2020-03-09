
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_magic_plant'
local monster_magic_plant = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_magic_plant:ctor(owner)
    Brain.ctor(self, owner, 'monster_magic_plant')
end

function monster_magic_plant:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return math.random()<0.3
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
                    PatrolTo(2),
                    WaitNode(2)
                )
            ),
        })
    )
end

return monster_magic_plant