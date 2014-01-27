-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require("physics")
local level01 = require("level01")
local sounds = require ("soundsfile")
local widget = require ("widget")
local params
local overlay


-- local forward references should go here --

local function btnTap(event)
	playSFX(audioclick)
	resetMusic(gamebgmusic)
	event.target.xScale = 0.95
	event.target.yScale = 0.95
	storyboard.gotoScene (  event.target.destination, {params ={curLevel = params.curLevel}, time=800, effect = "fade"} )
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
	

overlay = display.newImage ("images/overlayv2.png", 900 , 500)
				overlay.x = centerX
				overlay.y = centerY
				group:insert (overlay)

local levelBtn = display.newImageRect ("images/levelBtn.png", 112, 116 )
				levelBtn.x = centerX
				levelBtn.y = centerY + overlay.height/2.2
				levelBtn.destination = "levels" 
				levelBtn:addEventListener("tap", btnTap)
				group:insert(levelBtn)	

local playBtn = display.newImageRect ("images/playBtn.png", 112, 116)
				playBtn.x = centerX - overlay.width / 3
				playBtn.y = centerY + overlay.height/2.2
				local function hideOverlay(event)
					playSFX(audioclick)
					storyboard.hideOverlay("fade", 800)
					resumeMusic(1)
				end 
				playBtn:addEventListener ("tap", hideOverlay)
				group:insert(playBtn)

local reloadBtn = display.newImageRect ("images/reloadbutton.png" ,112, 116)
				reloadBtn.x = centerX + overlay.width / 3 
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
--pauseMusic(gamebgmusic)



local function switchPressed (event)

local id = event.target.id
	if id == "soundMusic" then 
	 	if musicisOn == true then 
		musicisOn = false
		audio.stop(1)
		else 
		musicisOn = true 
		playgameMusic (gamebgmusic)
	 	end 
	end

	if id == "soundSFX" then 
		if soundisOn == true then 
		soundisOn = false
		else 
		soundisOn = true 
	 	end 
	end
end 

 


checkboxMusic = widget.newSwitch( { id = "soundMusic" , style = "checkbox", initialSwitchState = musicisOn , onPress = switchPressed} )
checkboxMusic.x = overlay.width/ 1.8
checkboxMusic.y = overlay.height/ 1.4
checkboxMusic.xScale = 2.0
checkboxMusic.yScale = 2.0 
group:insert(checkboxMusic)

local musicText = display.newText ("Switch on/off music", 0, 0, "Helvetica", 36)
musicText:setReferencePoint (display.CenterLeftReferencePoint)
musicText.x = overlay.width/ 1.8 + 50
musicText.y = overlay.height/ 1.4
group:insert(musicText)

checkboxSFX = widget.newSwitch( {id = "soundSFX" , style = "checkbox", initialSwitchState = soundisOn , onPress = switchPressed} )
checkboxSFX.x = overlay.width/ 1.8
checkboxSFX.y = overlay.height/ 1.1
checkboxSFX.xScale = 2.0
checkboxSFX.yScale = 2.0 
group:insert(checkboxSFX)

local soundText = display.newText ("Switch on/off sound effects", 0, 0, "Helvetica", 36)
soundText:setReferencePoint (display.CenterLeftReferencePoint)
soundText.x = overlay.width/ 1.8 + 50
soundText.y = overlay.height/ 1.1
group:insert(soundText)





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