-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- local forward references should go here --

local physics = require("physics")
physics.start()
physics.setGravity(0, 0)	
--physics.setDrawMode( "hybrid" )
local onCollision
local audiolaunchBear

local function btnTap(event)
	storyboard.gotoScene (  event.target.destination, {effect = "fade"} )
	return true
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	local myStaticgroup = display.newGroup()

	-- CREATE display objects and add them to 'group' here.
	-- Example use-case: Restore 'group' from previously saved state.

--create wall objects
local topWall = display.newRect( 0, 0, display.contentWidth, 0 )
local bottomWall = display.newRect( 0, display.contentHeight - 10, display.contentWidth, 0 )
local leftWall = display.newRect( 0, 0, 0, display.contentHeight )
local rightWall = display.newRect( display.contentWidth - 10, 0, 0, display.contentHeight )
topWall.myName = "topwall"
bottomWall.myName = "bottomwall"
leftWall.myName = "leftwall"
rightWall.myName = "rightwall"
physics.addBody(topWall, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})
physics.addBody(bottomWall, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})
physics.addBody(leftWall, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})
physics.addBody(rightWall, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})

local bush01 = display.newImageRect ("images/bush01.png", 384	, 145		)
bush01.y = heightScrn - bush01.height 
bush01.x = display.screenOriginX + 128
bush01.alpha = 1.0
group:insert(bush01)

local bush02 = display.newImageRect ("images/bush01.png", 384	, 145		)
bush02.y = heightScrn - bush02.height 
bush02.x = display.screenOriginX + 370
bush02.alpha = 0.7
group:insert(bush02)

local backgroundBush = display.newImageRect ("images/backgroundbush.png", 1428	, 128		)
backgroundBush.y = heightScrn - backgroundBush.height /2
backgroundBush.x = centerX
backgroundBush.alpha = 0.7
group:insert(backgroundBush)

local floor = display.newImageRect ("images/floortitlescreen.png", 1425	, 156		)
floor.x = centerX; floor.y = heightScrn
physics.addBody(floor, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})
floor.myName = "floor"
group:insert(floor)

local rock = display.newImageRect ("images/rock100.png", 300, 96)
rock.x = display.screenOriginX + 160; rock.y = heightScrn	- floor.height / 1.5
group:insert(rock)

local woodSignStart = display.newImageRect ("images/woodsignleft.png", 100, 100)
woodSignStart.x = display.screenOriginX + 250; woodSignStart.y = heightScrn	- floor.height / 2
woodSignStart.rotation = 10
group:insert(woodSignStart)

local woodSignEnd = display.newImageRect ("images/woodsignright.png", 105, 105)
woodSignEnd.x = withScrn - 250; woodSignEnd.y = heightScrn + 200
woodSignEnd.rotation = -10
group:insert(woodSignEnd)
transition.to( woodSignEnd, { time=2000, x = withScrn - 250, y  =heightScrn	- floor.height / 3 })

local switchOff = display.newImageRect ("images/woodleverup.png", 64, 64)
switchOff.x = rock.x -10; switchOff.y = rock.y + 10
group:insert(switchOff)

local function launchRollyBear (event)
	display.remove( switchOff)
	audio.play(audioaunchBear)
	audio.setVolume(0.01, {audioaunchBear} ) 
	local switchOn = display.newImageRect ("images/woodleverdown.png", 64, 64)
	switchOn.x = rock.x -10; switchOn.y = rock.y + 10
	group:insert(switchOn)
	rollybear:applyForce(800, 30)
	rollybear:toFront()
	local function setPipeNormal()
		pipe.xScale = 1.0
		pipe.yScale = 1.0
	end
	transition.to( pipe, {time=100, xScale = 1.2, yScale = 1.2, onComplete=setPipeNormal}  )
end
switchOff:addEventListener ("tap",launchRollyBear)

pipe = display.newImageRect ("images/pipe.png", 144, 224)
pipe.rotation = 90
pipe.x = leftScrn; pipe.y = display.screenOriginY + pipe.height/2
physics.addBody(pipe, "static", {density = 1, friction = 0, bounce = 1, isSensor = true  })
group:insert (pipe)

rollybear = display.newImage ("images/rollybear40.png")
rollybear.x = leftScrn+10; rollybear.y = pipe.y
physics.addBody(rollybear, "dynamic", {density = 1, friction = 0, bounce = 1, isSensor = false, radius = 0})
rollybear.isBullet = true
rollybear.myName = "rollybear"
myStaticgroup:insert(rollybear)
group:insert(rollybear)
rollybear:toBack()


local chestClosed = display.newImageRect("images/chestclosed.png", 128 , 128)
chestClosed.x = withScrn - chestClosed.width 
chestClosed.y = floor.y - chestClosed.height
group:insert(chestClosed)


end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

--soundeffects 
audioaunchBear = audio.loadSound ("audio/wee.mp3")


 function onCollision(event)
			if(event.object1.myName=="rightwall" and event.object2.myName=="rollybear")
				or
				(event.object1.myName=="leftwall" and event.object2.myName=="rollybear")
				or 
				(event.object1.myName=="topwall" and event.object2.myName=="rollybear")
				or 
				(event.object1.myName=="bottomwall" and event.object2.myName=="rollybear")
				or
				(event.object1.myName=="floor" and event.object2.myName=="rollybear")
			 then
			 	-- temp solution for gameover
  				print("yeah collision works, I hit the "..event.object1.myName)
  				gameoverbtn = display.newText(  "GameOver", 0, 0, "Helvetica", 50)
  				gameoverbtn.x = centerX
  				gameoverbtn.y = centerY
  				display.remove( rollybear)
  				gameoverbtn.destination = "levels" 
  				gameoverbtn:addEventListener ("touch", btnTap)
  				group:insert(gameoverbtn)
  				
  		end
	end

	Runtime:addEventListener("collision", onCollision)


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