-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

-- external Moduals & libraries --

local storyboard = require( "storyboard" )
local _overlay = require( "gameoveroverlay" )
local _level01 = require("level01")
local scene = storyboard.newScene()

local loadText 
local params


local function restartLevel (event)
	storyboard.removeScene("level0"..params.curLevel)
	storyboard.gotoScene ("level0"..params.curLevel, {time=500, effect= "fade"})
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	myStaticgroup = self.view 

params = event.params
print(params.curLevel)

loadText = display.newText("Getting RollyBear in Postion", 0, 0 , "Helvetica", 50)
loadText.x = centerX
loadText.y = centerY
group:insert (loadText)

end 


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	myStaticgroup = self.view 

	loadText.alpha = 1.0
	transition.to( loadText, {time=250, alpha = 0.0, onComplete=restartLevel} )

end 


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	

	-- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks
	

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	myStaticgroup = self.view 
	



	-- INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )


---------------------------------------------------------------------------------

return scene----------------------------------------------------------

