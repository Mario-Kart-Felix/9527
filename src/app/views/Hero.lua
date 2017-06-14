local Hero = class("Hero", cc.load("mvc").ViewBase)


function Hero:onCreate()
	display.newLayer()
        :onTouch(handler(self, self.onTouch))
        :addTo(self)

    self._isMoved = false
    self._prevArmatureScale = 0.0
    self._armatureScale = 0.0
    self._startPoint = cc.p(0, 0)
    self._armatureIndex = 0
    self._animationIndex = 1
    self._dragonBonesData = null
    self._armature = null
    self._armatureDisplay = null
    self._factory = null

    self._factory = db.CCFactory:getInstance()
    self._dragonBonesData = self._factory:loadDragonBonesData("DragonBoy/Dragon_ske.json")
    self._factory:loadTextureAtlasData("DragonBoy/Dragon_tex.json")

    self:changeArmature()
    self:changeAnimation()
end




function Hero:onTouch(event)
    -- local x, y = event.x, event.y

    -- local touchRight = x > display.width * 0.5

    -- if(table.getn(self._dragonBonesData:getArmatureNames()) > 1 and not touchRight) then
    --     self:changeArmature()
    -- end
    -- self:changeAnimation()
    print("Hero,OnTouch.")

    self:changeAnimation()

    local bone1 = self._armature:getBone("head")
end

function Hero:changeArmature()
    local armatureNames = self._dragonBonesData:getArmatureNames()
    if(table.getn(armatureNames) == 0) then
        return
    end

    if(self._armature) then
        self._armature:dispose()
        self._armatureDisplay:removeSelf()
    end

    self._armatureIndex = self._armatureIndex + 1

    if(self._armatureIndex > table.getn(armatureNames)) then
        self._armatureIndex = 1
    end

    local armatureName = armatureNames[self._armatureIndex]

    self._armatureDisplay = self._factory:buildArmatureDisplay(armatureName)
    self._armature = self._armatureDisplay:getArmature();


    self._armatureDisplay:move(display.center)
    self._armatureDisplay:addTo(self);

    self._animationIndex = 0
end


function Hero:changeAnimation()
    local animationNames = self._armatureDisplay:getAnimation():getAnimationNames()
    if(table.getn(animationNames) == 0) then
        return
    end

    -- Get next Animation name.
    self._animationIndex = self._animationIndex + 1
    if (self._animationIndex > table.getn(animationNames)) then
        self._animationIndex = 1;
    end

    local animationName = animationNames[self._animationIndex]

    -- self._armatureDisplay:getAnimation():play(animationName)
    self._armatureDisplay:getAnimation():play("walk")

    print(self._animationIndex .. " " .. animationName)

end

return Hero