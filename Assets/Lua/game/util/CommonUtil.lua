
---------------------------------------------------------------------------------------------------
--
--filename: game.util.CommonUtil
--date:2019/10/9 17:18:06
--author:heguang
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'CommonUtil'
local CommonUtil = lua_declare(strClassName, lua_class(strClassName))

--------------------------------localkey--------------------------------
CommonUtil.localkey_accountname = "oz_login_accountname_"
CommonUtil.localkey_password = "oz_login_password_"
CommonUtil.localkey_key = "oz_login_key_"

-------------------------------------------------------------------------

CommonUtil.cameraRotate = 55
CommonUtil.mapScaleZ = 1/Mathf.Sin(CommonUtil.cameraRotate*Mathf.PI/180)

CommonUtil.highlightColor = Color(1,0.82,0.35)

CommonUtil.hitType_normal = 1 --普通伤害
CommonUtil.hitType_crit = 2 --暴击
CommonUtil.hitType_headShot = 3 --爆头
CommonUtil.hitType_miss = 4 --闪避
CommonUtil.hitType_body = 5 --碰撞伤害

return CommonUtil
