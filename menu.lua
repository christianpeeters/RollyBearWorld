-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")


-- local forward references should go here --


local function btnTap(event)
	storyboard.gotoScene (  event.target.destination, {effect = "fade"} )
	return true
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- CREATE display objects and add them to 'group' here.
	-- Example use-case: Restore 'group' from previously saved state.


	local title = display.newImageRect( "images/gameTitle.png", 910 , 139 )
	title.x = centerX
	title.y  = topScrn + title.height 
	group:insert(title)

	clouds ={
	 {getImage = "images/cloud01.png"}, 
	 {getImage = "images/cloud02.png"},
	 {getImage = "images/cloud03.png"}
	}

	for i=0,2 do

	imagesId = math.random (1,3)
	local cloud = display.newImage(clouds[imagesId].getImage   )
	cloud.x = math.random (display.screenOriginX , centerX )
	cloud.y = math.random (display.screenOriginY + cloud.height, centerY)
	group:insert(cloud)
	cloud.alpha = 0.7
	transition.to( cloud, {time = math.random (30000 , 120000), x = withScrn + 300 } )

	end 

	local bush01 = display.newImageRect ("images/bush01.png", 384	, 145		)
	bush01.y = heightScrn - bush01.height 
	bush01.x = display.screenOriginX + 128
	bush01.alpha = 1.0
	group:insert(bush01)

	local bush02 = display.newImageRect ("images/bush01.png", 384, 145		)
	bush02.y = heightScrn - bush02.height 
	bush02.x = display.screenOriginX + 370
	bush02.alpha = 0.7
	group:insert(bush02)


	local backgroundBush = display.newImageRect ("images/backgroundbush.png", 1428	, 128		)
	backgroundBush.y = heightScrn - backgroundBush.height /2
	backgroundBush.x = centerX
	backgroundBush.alpha = 0.7
	group:insert(backgroundBush)

	local fence = display.newImageRect ("images/fence02.png", 170	, 96		)
	fence.y = heightScrn - fence.height - 30
	fence.x = display.contentWidth - 250
	fence.alpha = 0.8
	group:insert(fence)

	local floor = display.newImageRect ("images/floortitlescreen.png", 1425	, 156		)
	floor.y = heightScrn
	floor.x = centerX
	group:insert(floor)

	local chestClosed = display.newImageRect("images/chestclosed.png", 128 , 128)
	chestClosed.x = display.screenOriginX + 1.3 * chestClosed.width 
	chestClosed.y = heightScrn - chestClosed.height
	group:insert(chestClosed)


	local function openChest()

		-- chest animation
		display.remove( chestClosed)
		local chestOpen = display.newImageRect("images/chestopen.png", 128, 128)
		chestOpen.x = display.screenOriginX + 1.3 * chestOpen.width 
		chestOpen.y = floor.y - chestClosed.height
		group:insert(chestOpen)
		-- heart / trophy animation 
		local trophy = display.newImageRect ("images/heart64.png", 64, 64)
		trophy.x = display.screenOriginX + 1.3 * chestClosed.width
		trophy.y = floor.y - floor.height 
		group:insert (trophy)
		local function fadeAway()
		transition.to( trophy, { time = 1500, xScale = 0, yScale =0 } )
		end
		transition.to( trophy, { time = 1300, y = centerY, xScale = 1.2, yScale = 1.2, onComplete = fadeAway}  )
	end
	
	chestClosed:addEventListener("tap", openChest)



	local rollybear = display.newImageRect("images/rollybeartitlescreen.png", 244, 239)
	rollybear.x = withScrn - 144 
	rollybear.y = heightScrn * 1.5
	rollybear.xScale = .45
	rollybear.yScale = .45
	transition.to( rollybear, {time= 1500, y = chestClosed.y -30 } )
	group:insert(rollybear) 

	local pipe = display.newImageRect("images/pipe.png", 144, 224)
	pipe.x = withScrn - pipe.width 
	pipe.y = heightScrn - 30 
	group:insert(pipe)


	-- create custom buttom
	local playBtn = widget.newButton
	{
	width = 500,
    height = 90,
    defaultFile = "images/button_notpressed.png",
    overFile = "images/button_pressed.png",
    label="Play Game",
	labelColor = { default = { 250, 255, 250}, 
						over ={0,0,0  }},
	fontSize = "46",
	}
	playBtn.x = centerX
	playBtn.y = centerY*1.2 - 1.2*playBtn.height
	playBtn.destination = "levels"
	playBtn:addEventListener("tap", btnTap)
	group:insert(playBtn)

	local optionsBtn = widget.newButton
	{
	width = 500,
    height = 90,
    defaultFile = "images/button_notpressed.png",
    overFile = "images/button_pressed.png",
    label="Options",
	labelColor = { default = { 250, 255, 250}, 
						over ={0,0,0  }},
	fontSize = "46",
	}
	optionsBtn.x = centerX
	optionsBtn.y = centerY*1.2
	optionsBtn.destination = "options"
	optionsBtn:addEventListener("tap", btnTap)
	group:insert(optionsBtn)

	local creditsBtn = widget.newButton
	{
	width = 500,
    height = 90,
    defaultFile = "images/button_notpressed.png",
    overFile = "images/button_pressed.png",
    label="Credits",
	labelColor = { default = { 250, 255, 250}, 
						over ={0,0,0  }},
	fontSize = "46",
	}
	creditsBtn.x = centerX
	creditsBtn.y = optionsBtn.y + 1.2 *creditsBtn.height
	creditsBtn.destination = "gamecredits"
	creditsBtn:addEventListener("tap", btnTap)
	group:insert(creditsBtn)

	
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

return scene---------------------------------------------------------

