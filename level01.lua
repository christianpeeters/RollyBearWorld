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
local totalnumPlatforms = {} -- table to store all platforms
local rotationalert 
local platformTouched
local checkLocation


local function btnTap(event)
	
	event.target.xScale = 0.95
	event.target.yScale = 0.95
	--
	storyboard.showOverlay( "pauseoverlay" ,{effect = "fade"  ,  params ={levelNum = "level01"}, isModal = true} )

	return true
end





-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	myStaticgroup = self.view 


-- Creation of background elements based on fixedScene.lua --- 


-- workaround to freeze the background elements when overlay is called



createStaticBackgroundElements()



createPipe ()
	setCoordinates (pipe, leftScrn, display.screenOriginY + pipe.height/2 )


createRolly()
	setCoordinates ( rollybear, leftScrn+10, pipe.y )

	

---------------




local pauseBtn = display.newImageRect ("images/pausebutton.png", 112, 117)
	pauseBtn.y = 7+ (topScrn+ pauseBtn.height /2) 
	pauseBtn.x = -7+ (withScrn - pauseBtn.width /2)
	pauseBtn.destination = "pauseBtn"
	pauseBtn:addEventListener("tap", btnTap)
	group:insert(pauseBtn)

end 


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	myStaticgroup = self.view 


	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

--soundeffects 
audioaunchBear = audio.loadSound ("audio/wee.mp3")

local function rotatePlatform(event)
	 alerttouched = event.target

	    	
        if (event.phase == "began") then
                display.getCurrentStage():setFocus( alerttouched )
 				
 				-- here the first position is stored in x and y 	         
              
	       elseif (event.phase == "moved") then

	       				platformTouched.x2 = event.x
	                    platformTouched.y2 = event.y
						
						angle1 = 180/math.pi * math.atan2(platformTouched.y1 - platformTouched.y , platformTouched.x1 - platformTouched.x)
	                    angle2= 180/math.pi * math.atan2(platformTouched.y2 - platformTouched.y , platformTouched.x2 - platformTouched.x)
	                  
	                    differencebetweenangles = angle1 - angle2
	 						
	 				    --rotate it
	                     platformTouched.rotation = platformTouched.rotation - differencebetweenangles
	                     
	                        
	                     platformTouched.x1 = platformTouched.x2
	                     platformTouched.y1 = platformTouched.y2


	       	elseif event.phase == "ended" or event.phase == "cancelled"  then

	       	display.remove( rotationalert )
	       	rotationalert = nil 

	       	display.getCurrentStage():setFocus( nil )

	       	
	       	-- somehow give error with startmoveX
	       	--timer.cancel (rotationTimer)

           end 

end 



local function movePlatform(event)
	 platformTouched = event.target

	    	
        if (event.phase == "began") then
                display.getCurrentStage():setFocus( platformTouched )
 				
 				
 				display.remove( rotationalert )
 				rotationalert = nil 
 		
 				-- here the first position is stored in x and y 	         
                platformTouched.startMoveX = platformTouched.x
				platformTouched.startMoveY = platformTouched.y

				platformTouched.x1 = event.x
                platformTouched.y1 = event.y


        		elseif (event.phase == "moved") then

                -- here the distance is calculated between the start of the movement and its current position of the drag	 
                	platformTouched.x = (event.x - event.xStart) + platformTouched.startMoveX
					platformTouched.y = (event.y - event.yStart) + platformTouched.startMoveY

						
                elseif event.phase == "ended" or event.phase == "cancelled"  then

              	
              		if platformTouched.x >= platformboard.x + 0.5*(platformboard.x) then
	              		rotationalert = display.newImage ("images/rotation.png")
	                	rotationalert.x = platformTouched.x
	                	rotationalert.y = platformTouched.y 
	                	rotationalert.alpha = 0.5 
	                	group:insert(rotationalert)
	                	rotationalert:addEventListener ("touch", rotatePlatform)
                	end 
	
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
	totalnumPlatforms [#totalnumPlatforms+1] = platform
	platform.platformNum= platformNum
	physics.addBody( platform, physicsData:get(platformNum))
	platform.bodyType = "static"  
	platform:addEventListener("touch", movePlatform)
	group:insert(platform)
end


local function launchRollyBear (event)
	display.remove(rotationalert)
	display.remove( switchOff)
	audio.play(audioaunchBear)
	audio.setVolume(0.01, {audioaunchBear} ) 
	local switchOn = display.newImageRect ("images/woodleverdown.png", 64, 64)
	switchOn.x = rock.x -10; switchOn.y = rock.y + 10
	group:insert(switchOn)
	rollybear:applyForce(800, 0)
	rollybear:toFront()
	local function setPipeNormal()
		pipe.xScale = 1.0
		pipe.yScale = 1.0
	end
	transition.to( pipe, {time=100, xScale = 1.2, yScale = 1.2, onComplete=setPipeNormal}  )
end
switchOff:addEventListener ("tap",launchRollyBear)

function checkLocation()

	for x = 1, #totalnumPlatforms do
		--print(#totalnumPlatforms)
		local platformScale = totalnumPlatforms[x]
	
		if platformScale.x > platformboard.x + 0.5*(platformboard.x) then
			platformScale.xScale = 1.0
			platformScale.yScale = 1.0
		end
		if platformScale.x <= platformboard.x + 0.5*(platformboard.x) then
			platformScale.xScale = 0.7
			platformScale.yScale = 0.7
			platformScale.rotation = 0
		end

	end
end



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
  				Runtime:removeEventListener("collision", onCollision)
  				rollybear.alpha = 0 
  				storyboard.showOverlay( "gameoveroverlay" ,{effect = "fromBottom"  ,  params ={levelNum = "level01"}, isModal = true} )


  				
  			end
	end


	Runtime:addEventListener("enterFrame", checkLocation)
	Runtime:addEventListener("collision", onCollision)
    




end 


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	myStaticgroup = self.view 
		
		if totalnumPlatforms ~= {} then
		for x = #totalnumPlatforms, 1, -1 do
			display.remove( totalnumPlatforms[x] )
			totalnumPlatforms[x] = nil
		end
		totalnumPlatforms = {}
	end 

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

