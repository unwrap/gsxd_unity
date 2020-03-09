
---------------------------------------------------------------------------------------------------
--
--filename: game.base.OzMonoBehaviour
--date:2019/9/21 11:39:10
--author:xxx
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.base.OzMonoBehaviour'
local OzMonoBehaviour = lua_declare(strClassName, lua_class(strClassName))

function OzMonoBehaviour:Start()
	print(">>>Base")
end

return OzMonoBehaviour
