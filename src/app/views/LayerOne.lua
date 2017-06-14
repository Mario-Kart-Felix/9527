local LayerOne = class("LayerOne",cc.load("mvc").ViewBase)
local size = cc.Director:getInstance():getWinSize()

local action = nil
local background_ = nil

local coolHairData = nil
local factory = nil
local armatureDisplay = nil
local armatureScale = nil


function LayerOne:LoadAnimation()
	factory = db.CCFactory:getInstance()
	coolHairData = factory:loadDragonBonesData("CoolHair/TestDragonBone_ske.json")
	factory:loadTextureAtlasData("CoolHair/TestDragonBone_tex.json")
	local armatureNames = coolHairData:getArmatureNames()

	for k,v in pairs(armatureNames) do
		local ll = coolHairData:getArmature(armatureNames[k])
	end

	armatureDisplay = factory:buildArmatureDisplay(armatureNames[2])
	-- local sprite = factory:getTextureDisplay()
	self:addChild(armatureDisplay)
	armatureDisplay:move(cc.p(size.width/2,size.height/2))
	armatureDisplay:setScale(0.2)
	local animationNames = armatureDisplay:getAnimation():getAnimationNames()
	armatureDisplay:getAnimation():play(animationNames[1])
end

function LayerOne:ctor()
	self.scene_ = cc.Scene:create()
	self.layer_ = cc.Layer:create()
	background_ = cc.Sprite:create("HelloWorld.png")
	background_:setPosition(cc.p(size.width/2, size.height/2))
	self.layer_:addChild(background_)
	-- self.layer_:onTouch(handler(self, self.onTouch))
	self.scene_:addChild(self.layer_)
	self:addChild(self.scene_)

	local listenner = cc.EventListenerTouchOneByOne:create()
	listenner:setSwallowTouches(true)
	listenner:registerScriptHandler(self.onTouch,cc.Handler.EVENT_TOUCH_BEGAN)
	listenner:registerScriptHandler(self.onTouchesEnd,cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listenner,self)

	self:LoadAnimation()
end


function LayerOne:update()


end


function LayerOne:onTouch(touches,event)
	local random = math.random()
	if(random < 0.20) then
		action = cc.ScaleBy:create(3,2)
	elseif(random < 0.40) then
		action = cc.RotateBy:create(3,360)
	elseif(random < 0.60) then
		action = cc.Blink:create(1,3)
	elseif(random < 0.80) then
		action = cc.TintBy:create(2,0,-255,-255)
	else
		action = cc.FadeOut:create(2)
	end
	local action_back = action:reverse()
	local seq = cc.Sequence:create(action,action_back)
	background_:runAction(cc.RepeatForever:create(seq))
	return true
end

function LayerOne:onTouchesEnd(touches,event)
	print("stopAction")
	-- background_:stopAction()
end

function LayerOne:onCreate()
	print("OnCreate")
end

return LayerOne