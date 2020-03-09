
local Brain = require('game.bt.Brain')
local AttackTarget = require('game.actions.AttackTarget')
local MoveToTarget = require('game.actions.MoveToTarget')
local PatrolTo = require('game.actions.PatrolTo')

local strClassName = 'game.brains.monster_mogumon1'
local monster_mogumon1 = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_mogumon1:ctor(owner)
    Brain.ctor(self, owner, 'monster_mogumon1')
end

function monster_mogumon1:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            IfElseNode(
                function()
                    return self.owner:CheckTarget(1.8)
                end,
                SequenceNode(
                {
                    AttackTarget("Attack4"),
                    WaitNode(1),
                }),
                IfElseNode(
                    function()
                        return math.random()<0.7
                    end,
                    MoveToTarget(1.6),
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

return monster_mogumon1