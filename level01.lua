-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

-- external Moduals & libraries --

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local fixedscene = require("fixedScene")


-- TexturePacker --

local sheetInfo = require("platformSheet")
local myPlatformSheet = graphics.newImageSheet( "platformsheet.png", sheetInfo:getSheet() )

-- Physics --

local physics = require("physics")
local physicsData = (require "platformshapes").physicsData(1.0)
physics.start()
physics.setGravity(0, 0)	
--physics.setDrawMode( "hybrid" )

-- GLobal Variables --

local onCollision
local audiolaunchBear
local platform




local function btnTap(event)
	storyboard.gotoScene (  event.target.destination, {effect = "fade"} )
	return true
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	myStaticgroup = self.view 

-- Creation of background elements based on fixedScene.lua --- 

createStaticBackgroundElements()


createPipe ()
	setCoordinates (pipe, leftScrn, display.screenOriginY + pipe.height/2 )


createRolly()
	setCoordinates ( rollybear, leftScrn+10, pipe.y )

	

---------------


local function movePlatform(event)
	local platformTouched = event.target
	    	
        if (event.phase == "began") then
                display.getCurrentStage():setFocus( platformTouched )
 				
 				-- here the first position is stored in x and y 	         
                platformTouched.startMoveX = platformTouched.x
				platformTouched.startMoveY = platformTouched.y

             
        		elseif (event.phase == "moved") then
                
                -- here the distance is calculated between the start of the movement and its current position of the drag	 
                	platformTouched.x = (event.x - event.xStart) + platformTouched.startMoveX
					platformTouched.y = (event.y - event.yStart) + platformTouched.startMoveY
								
					
                elseif event.phase == "ended" or event.phase == "cancelled"  then
              	
              	-- here the focus is removed from the last position
                    display.getCurrentStage():setFocus( nil )

                end
                 return true
        end



platformNames = {"platform-brown128", "platform-brownbrick128", "platform-green64", "platform-rock128", "crate64"};

for x =1, #platformNames do
	local platformNum = platformNames[x]
	platform = display.newSprite( myPlatformSheet , {frames={sheetInfo:getFrameIndex(platformNum)}} )
	platform.x = display.screenOriginX + 100
	platform.y = 150 + 75 * x 
	physics.addBody( platform, physicsData:get(platformNum))
	platform.bodyType = "static"  
	
	local function enableRotation()
			if (objectRotation == false) then
			objectRotation = true 
			else
			objectRotation = false 
			end
	end
	platform:addEventListener("touch", movePlatform)
	group:insert(platform)

end


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



local backbtn = display.newImageRect ("images/reloadbutton.png", 112, 117)
	backbtn.y = centerY 
	backbtn.x = centerX
	backbtn.destination = "levels" 
	backbtn:addEventListener("tap", btnTap)
	group:insert(backbtn)
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	myStaticgroup = self.view 


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
	myStaticgroup = self.view 


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

return scene