-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- local forward references should go here --

levels = 
{	
1, 2, 2, 2 , 2,  --1 means level is open to be played 
2, 2, 2, 2, 2,   --2 means level is locked 
2, 2, 2, 2, 2   
}
	
images ={
	{ getFile = "images/leveliconnotpressed.png", types = "play"   },
	{ getFile = "images/levellocked.png", types = "locked"}
	
}

local function btnTap(event)
	storyboard.gotoScene (  event.target.destination, {effect = "fade"} )
	return true
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- CREATE display objects and add them to 'group' here.
	-- Example use-case: Restore 'group' from previously saved state.

	local levelIndex =0
		for i=0,1 do
			for j=1,5 do
				tablePlace =   i*5 + j	
				levelIndex = levelIndex + 1
					local imagesId = levels[levelIndex] 
						levelImg = display.newImageRect (images[imagesId].getFile , 150, 150 )
						levelImg.x = 120 + (j* 175 )
						levelImg.y  = 300 + (i* 175 )
						group:insert(levelImg)


						if images[imagesId].types == "play" then
						leveltxt = display.newText("Level "..tostring(tablePlace), 0,0, "Helvetica", 30)
						leveltxt.x = 120 + (j*175)
						leveltxt .y = 300+ (i*175)
						leveltxt:setTextColor (250, 255, 251)
						group:insert (leveltxt)
						end 				   
						
end
	
end

	local title= display.newImage ("images/levelstitle.png")
	title.x = centerX
	title.y  = topScrn + title.height 
	group:insert(title)
	
	local backbtn = display.newImage ("images/reloadbutton.png")
	backbtn.y = heightScrn - 0.6 * backbtn.height 
	backbtn.x = .6 * backbtn.width 
	backbtn.destination = "menu" 
	backbtn:addEventListener("tap", btnTap)
	group:insert(backbtn)

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