
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.boss_shaman'
local boss_shaman = lua_declare(strClassName, lua_class(strClassName, Brain))

function boss_shaman:ctor(owner)
    Brain.ctor(self, owner, 'boss_shaman')
end

function boss_shaman:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return math.random()<0.6
                end,
                SelectorNode(
                {
                    IfNode(
                        function()
                            return math.random()<0.3
                        end,
                        SequenceNode(
                        {
                            AttackTarget("Attack2"),
                            WaitNode(1),
                        })
                    ),
                    IfNode(
                        function()
                            return math.random()<0.35
                        end,
                        SequenceNode(
                        {
                            AttackTarget("Attack1"),
                            WaitNode(1),
                        })
                    ),
                }),
                PatrolTo(2)
            ),
        })
    )
end

return boss_shaman