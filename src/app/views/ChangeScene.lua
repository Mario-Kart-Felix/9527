local ChangeScene = class("ChangeScene",
	function()
    	return display.newScene("ChangeScene")
    end
    )


local rb = nil

function ChangeScene:ctor()
	print("ChangeScene")
	rb = cc.CSLoader:createNode("Scene2.csb")
    self:addChild(rb)
end

function ChangeScene:onEnter()
	print("Custom ChangeScene:onEnter")
end

return ChangeScene