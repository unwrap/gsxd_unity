require("const.require_global")
require("const.requires")

local function main()
	Application.targetFrameRate = 30
	Screen.sleepTimeout = UnityEngine.SleepTimeout.NeverSleep
	Application.runInBackground = true
	FPS.Instance:Init()

	GlobalData:Reset()

	LocalizationImporter.RegisterLuaFunction(LuaGameUtil.GetText)
	OzGameManager.Instance:Init()

	OzAdsManager.Instance:Init(true, "7Ae0709dLBV308yl4q2u")
	OzAdsManager.Instance:PreloadAd()

	if not lua_is_declared("OzJoystick") then
		local joystick = lua_declare("OzJoystick", {})
		OzJoystick.joystickAxis = Vector2.zero
		OzJoystick.joystickDir = 0
	end

	---[[
	local loading = GameObject.Find("~TransitionCanvas")
	if loading == nil then
		loading = GameUtil.Instantiate(Resources.Load("Prefabs/TransitionCanvas"))
		loading.name = "~TransitionCanvas"
	end
	if loading ~= nil then
		LuaGameUtil.DoFile(loading, "game.ui.transition.SceneTransition", true)
	end
	--]]

	local startView = UIManager.Instance.ContentRoot:Find("bootstrap")
	local luaMono = LuaGameUtil.DoFile(startView.gameObject, "game.bootstrap.Bootstrap")
end

local function Update()
	OzUpdater.Instance():Update()
end

local function LateUpdate()
	OzUpdater.Instance():LateUpdate()
end

local function FixedUpdate()
	OzUpdater.Instance():FixedUpdate()
end

local function LiteUpdate()
	OzUpdater.Instance():LiteUpdate()
end

local function Destroy()
	LocalizationImporter.OnDestroy()
end

lua_declare("main", main)
lua_declare("Update", Update)
lua_declare("LateUpdate", LateUpdate)
lua_declare("FixedUpdate", FixedUpdate)
lua_declare("LiteUpdate", LiteUpdate)
lua_declare("Destroy", Destroy)

