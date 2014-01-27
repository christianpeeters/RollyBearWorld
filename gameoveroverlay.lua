-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require("physics")
local level01 = require("level01")
local sounds = require ("soundsfile")

-- local forward references should go here --

local function btnTap(event)
	playSFX(audioclick)
	resetMusic(gamebgmusic)
	event.target.xScale = 0.95
	event.target.yScale =0.95
	
	--storyboard.gotoScene (event.target.destination, { params ={levelNum = params.levelNum}, effect = "fade"} )
	storyboard.gotoScene (event.target.destination, { params ={curLevel = params.curLevel}, effect = "fade"} )
	return true
end

 function catchBackgroundOverlay(event)
	return true 
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

local backgroundOverlay = display.newRect (group, leftScrn-1000, topScrn-1000, withScrn+1000, heightScrn+1000)
			backgroundOverlay:setFillColor( black )
			backgroundOverlay.alpha = 0.6
			backgroundOverlay.isHitTestable = true
			backgroundOverlay:addEventListener ("tap", catchBackgroundOverlay)
			backgroundOverlay:addEventListener ("touch", catchBackgroundOverlay)

local overlay = display.newImageRect ("images/overlay_tryagain.png", 400 , 250)
			overlay.x = centerX
			overlay.y = centerY
			group:insert (overlay)

local levelBtn = display.newImageRect ("images/levelBtn.png", 112, 116 )
			levelBtn.x = centerX + overlay.width / 4
			levelBtn.y = centerY + overlay.height/2.2
			levelBtn.destination = "levels" 
			levelBtn:addEventListener("tap", btnTap)
			group:insert(levelBtn)	


local reloadBtn = display.newImageRect ("images/reloadbutton.png" ,112, 116)
			reloadBtn.x = centerX - overlay.width / 4
			reloadBtn.y = centerY + overlay.height/2.2
			params = event.params
			reloadBtn.destination = "reloading"
			reloadBtn:addEventListener ("tap", btnTap)
			group:insert (reloadBtn)

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