
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.ctrl.AnimationMonsterCtrl
--date:2019/9/30 18:00:31
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local AnimationCtrlBase = require("game.entities.ctrl.AnimationCtrlBase")

local strClassName = 'game.entities.ctrl.AnimationMonsterCtrl'
local AnimationMonsterCtrl = lua_declare(strClassName, lua_class(strClassName, AnimationCtrlBase))

function AnimationMonsterCtrl:ctor(owner, anim, rigidbody)
	AnimationCtrlBase.ctor(self, owner, anim, rigidbody)
end

return AnimationMonsterCtrl
