
local CoolHairBoom = class("CoolHairBoom",cc.load("mvc").ViewBase)
local size = cc.Director:getInstance():getWinSize()
local factory_ = nil
local dbdata = nil
local texdata = nil
local myplay = nil
local dbnames = nil


local worldCl = nil

local resourceNode_ = nil
local testBtn = nil
local ldBar = nil

local panel1 = nil
local layer1 = nil

local action = nil

function CoolHairBoom:ctor()
	factory_ = db.CCFactory:getInstance()
	dbdata = factory_:loadDragonBonesData("CoolHair/TestDragonBone_ske.json")
	texdata = factory_:loadTextureAtlasData("CoolHair/TestDragonBone_tex.json")
	dbnames = dbdata:getArmatureNames()
	myplay = factory_:buildArmatureDisplay(dbnames[2])

	self:addChild(myplay)
	myplay:move(cc.p(size.width/2,size.height/2))
	myplay:setScale(0.2)

	myplay:bindDragonEventListener(handler(self,self.MyEvent))
	-- display:addDragonEventType("start")
    -- display:addDragonEventType("loopComplete")
    -- display:addDragonEventType("complete")
    myplay:addDragonEventType("frameEvent")

	local listenner = cc.EventListenerTouchOneByOne:create()
	listenner:setSwallowTouches(true)
	listenner:registerScriptHandler(self.onTouch,cc.Handler.EVENT_TOUCH_BEGAN)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listenner,self)

end

function CoolHairBoom:MyEvent(typename,name,eventobj,obj)
	-- print(eventobj:AnimationState():getName())
	-- print(eventobj:Slot()) nil
	-- print(eventobj:Frame()) nil
	-- print(eventobj:Armature():getSlot("zuotoufa"):getDisplayIndex()) ok
	-- print(eventobj:AnimationState():getAnimationData():getBoneTimeline("zuotoufa"))
	-- print(eventobj:AnimationState():getCurrentTime())
	-- print(eventobj:AnimationState():fadeOut(0.5))
	-- print(eventobj:AnimationState():getGroup())
	-- eventobj:Armature():getAnimation():fadeIn("cool",-1,-1,0,"")  crash

	myplay:removeEvent("frameEvent")
	myplay:dispose()
	myplay:removeSelf()
	myplay = nil

	resourceNode_ = cc.CSLoader:createNode("MainScene.csb")
	action = cc.CSLoader:createTimeline("MainScene.csb")
    self:addChild(resourceNode_)

    resourceNode_:runAction(action)
    action:gotoFrameAndPlay(0,40,false)

    --[[ Sprite Use method one.]]
    -- display.loadSpriteFrames("res/UI/juese_info.plist","res/UI/juese_info.png")
    -- sprite:setSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("jisha.png"))

    --[[ Button ]]
    -- btn:loadTextures("btn_u.png","btn_u.png","",1)
    testBtn = resourceNode_:getChildByName("TestButton")
    if(testBtn ~= nil) then
    	testBtn:addClickEventListener(
    			function(sender)
    				print("ButtonClick")
    			end
    		)
    end

    --[[ Image view ]]
    -- image:loadTexture("image_gong.png",1)

    --[[ float to int ]]
    -- local temp = 10/3
	-- log(math.ceil(temp))

	--[[ loading bar ]]
	ldBar = resourceNode_:getChildByName("LoadingBar")
	ldBar:setPercent(50)

	panel1 = resourceNode_:getChildByName("LayerPanel")
	panel1:setVisible(true)

	layer1 = resourceNode_:getChildByName("LayerOne")
	layer1:setVisible(true)
end


function CoolHairBoom:onTouch(event,touch)
	print("play")
	-- print(display:getAnimation():getState("cool"))
	if(myplay ~= nil) then
		myplay:getAnimation():gotoAndPlayByTime("cool",1,1)
	else
		-- local view = self:createView( "ChangeScene" )  
		local nextSc = require "app/views/ChangeScene"
		cc.exports.bl = nextSc:new()
    	local scene = display.newScene( "ChangeScene" )  
		-- local transition = cc.TransitionJumpZoom:create( 0.5, scene )  
		cc.Director:getInstance():replaceScene(bl) 
	end
	-- display:getAnimation():gotoAndPlayByFrame("cool",100,1)
	-- display:getAnimation():gotoAndPlayByProgress("cool",0.5,1)
	-- display:getAnimation():gotoAndStopByTime("cool",5)
	-- display:getAnimation():gotoAndStopByFrame("cool",23)
	-- display:getAnimation():gotoAndStopByProgress("cool",0.5)
	-- worldCl = db.WorldClock:getInstance()
end




return CoolHairBoom