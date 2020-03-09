
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.ctrl.AnimationHeroCtrl
--date:2019/9/30 18:00:11
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local AnimationCtrlBase = require("game.entities.ctrl.AnimationCtrlBase")

local strClassName = 'game.entities.ctrl.AnimationHeroCtrl'
local AnimationHeroCtrl = lua_declare(strClassName, lua_class(strClassName, AnimationCtrlBase))

function AnimationHeroCtrl:ctor(owner, anim, rigidbody)
	AnimationCtrlBase.ctor(self, owner, anim, rigidbody)
end

function AnimationHeroCtrl:DoAttack(aniName)
	self.anim:SetBool(aniName, true)
end

return AnimationHeroCtrl
