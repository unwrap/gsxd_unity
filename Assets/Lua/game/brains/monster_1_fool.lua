
local Brain = require('game.bt.Brain')

local strClassName = 'game.brains.monster_1_fool'
local monster_1_fool = lua_declare(strClassName, lua_class(strClassName, Brain))

function monster_1_fool:ctor(owner)
    Brain.ctor(self, owner, 'monster_1_fool')
end

function monster_1_fool:OnStart()
    self.bt = BehaviourTree(self, 
        SelectorNode(
        {
            WaitNode(10),
        })
    )
end

return monster_1_fool