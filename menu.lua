-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- local forward references should go here --

local function btnTap(event)
	storyboard.gotoScene (  event.target.destination, {effect = "slideDown"} )
	return true
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- CREATE display objects and add them to 'group' here.
	-- Example use-case: Restore 'group' from previously saved state.


	local title = display.newText( "Rolly Bear World", 0, 0, "Helvetica", 38 )
	title.x = centerX
	title.y = display.screenOriginY + 40
	group:insert(title)
	
	local playBtn = display.newText(  "Start game", 0, 0, "Helvetica", 25 )
	playBtn.x = centerX
	playBtn.y = centerY
	playBtn.destination = "play" 
	playBtn:addEventListener("tap", btnTap)
	group:insert(playBtn)
	
	local optionsBtn = display.newText(  "Options", 0, 0, "Helvetica", 25 )
	optionsBtn.x = centerX
	optionsBtn.y = centerY + 80 
	optionsBtn.destination = "options" 
	optionsBtn:addEventListener("tap", btnTap)
	group:insert (optionsBtn)
	
	local creditsBtn = display.newText(  "Credits", 0, 0, "Helvetica", 25 )
	creditsBtn.x = centerX
	creditsBtn.y = centerY + 160
	creditsBtn.destination = "gamecredits" 
	creditsBtn:addEventListener("tap", btnTap)
	group:insert (creditsBtn)
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	-- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-- Remove listeners attached to the Runtime, timers, transitions, audio tracks

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

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

return scene