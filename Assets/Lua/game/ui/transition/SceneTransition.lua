
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.transition.SceneTransition
--date:2019/11/20 9:37:56
--author:heguang
--desc:场景切换
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.transition.SceneTransition'
local SceneTransition = lua_declare(strClassName, lua_class(strClassName))

function SceneTransition:Start()
	GameObject.DontDestroyOnLoad(self.gameObject)

	self.rootObject = self.transform:FindChild("root").gameObject
	self.rootObject:SetActive(false)

	self.infoText = LuaGameUtil.GetTextComponent(self.transform, "root/Text")

	self.imgCanvas = self.gameObject:GetComponent(CanvasGroup)
	self.imgCanvas.alpha = 0

	self.animTime = 0.05
	self.isShowAnim = false
	self.showTimer = 0
	self.isHideAnim = false
	self.hideTimer = 0

	OzMessage:addEvent(CommonEvent.ShowSceneTransition, self.StartShow, self)
	OzMessage:addEvent(CommonEvent.HideSceneTransition, self.StartHide, self)
end

function SceneTransition:OnDestroy()
	OzMessage:removeEvent(CommonEvent.ShowSceneTransition, self.StartShow, self)
	OzMessage:removeEvent(CommonEvent.HideSceneTransition, self.StartHide, self)
end

function SceneTransition:StartShow(sceneName, isBattleScene)
	self.levelName = sceneName
	self.isBattleScene = isBattleScene
	self.isShowAnim = true
	self.showTimer = 0
	self.imgCanvas.alpha = 0
	self.rootObject:SetActive(true)
	self.infoText.text = ""
	self.imgCanvas.interactable = true
	self.imgCanvas.blocksRaycasts = true
end

function SceneTransition:StartHide()
	self.isHideAnim = true
	self.hideTimer = 0
	self.imgCanvas.alpha = 1
	self.rootObject:SetActive(true)
end

function SceneTransition:Update()
	if self.isShowAnim then
		self.showTimer = self.showTimer + Time.deltaTime
		if self.showTimer < self.animTime then
			local t = self.showTimer / self.animTime
			self.imgCanvas.alpha = Mathf.Lerp(0, 1, t)
		else
			self.imgCanvas.alpha = 1
			self.isShowAnim = false

			if self.isBattleScene then
				self.infoText.text = LuaGameUtil.GetText(400003)
			else
				self.infoText.text = ""
			end

			local loadLevelFinish = function()
				print("load:", self.levelName)
				if self.isBattleScene then
					GameBattleManager.Instance():EnterScene()
				end
				GameUtil.EndMarkTime("load scene", 0)
				self:StartHide()
			end
			GameUtil.BeginMarkTime()
			AssetBundleManager.LoadLevel( "scene/" .. self.levelName .. ".u3d", self.levelName, loadLevelFinish )
		end
	elseif self.isHideAnim then
		self.hideTimer = self.hideTimer + Time.deltaTime
		if self.hideTimer < self.animTime then
			local t = self.hideTimer / self.animTime
			self.imgCanvas.alpha = 1 - t
		else
			self.isHideAnim = false
			self.imgCanvas.alpha = 0
			self.rootObject:SetActive(false)
			self.imgCanvas.interactable = false
			self.imgCanvas.blocksRaycasts = false
		end
	end
end

return SceneTransition
