-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com
-- All fixed scene elements of levels and a contructor for the location of the Pipe and RollyBear
myStaticgroup = display.newGroup()

function createStaticBackgroundElements()
-- create all fixed background elements
	topWall = display.newRect( 0, 0, display.contentWidth, 0 )
	bottomWall = display.newRect( 0, display.contentHeight - 10, display.contentWidth, 0 )
	leftWall = display.newRect( 0, 0, 0, display.contentHeight )
	rightWall = display.newRect( display.contentWidth - 10, 0, 0, display.contentHeight )
	topWall.myName = "topwall"
	bottomWall.myName = "bottomwall"
	leftWall.myName = "leftwall"
	rightWall.myName = "rightwall"
	physics.addBody(topWall, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})
	physics.addBody(bottomWall, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})
	physics.addBody(leftWall, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})
	physics.addBody(rightWall, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})

	bush01 = display.newImageRect ("images/bush01.png", 384	, 145		)
	bush01.y = heightScrn - bush01.height 
	bush01.x = display.screenOriginX + 128
	bush01.alpha = 1.0

	bush02 = display.newImageRect ("images/bush01.png", 384	, 145		)
	bush02.y = heightScrn - bush02.height 
	bush02.x = display.screenOriginX + 370
	bush02.alpha = 0.7

	backgroundBush = display.newImageRect ("images/backgroundbush.png", 1428	, 128		)
	backgroundBush.y = heightScrn - backgroundBush.height /2
	backgroundBush.x = centerX
	backgroundBush.alpha = 0.7

	floor = display.newImageRect ("images/floortitlescreen.png", 1425	, 156		)
	floor.x = centerX; floor.y = heightScrn
	physics.addBody(floor, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})
	floor.myName = "floor"

	rock = display.newImageRect ("images/rock100.png", 300, 96)
	rock.x = display.screenOriginX + 160; rock.y = heightScrn	- floor.height / 1.5

	woodSignStart = display.newImageRect ("images/woodsignleft.png", 100, 100)
	woodSignStart.x = display.screenOriginX + 250; woodSignStart.y = heightScrn	- floor.height / 2
	woodSignStart.rotation = 10

	woodSignEnd = display.newImageRect ("images/woodsignright.png", 105, 105)
	woodSignEnd.x = withScrn - 250; woodSignEnd.y = heightScrn + 200
	woodSignEnd.rotation = -10
	transition.to( woodSignEnd, { time=2000, x = withScrn - 250, y  =heightScrn	- floor.height / 3 })

	chestClosed = display.newImageRect("images/chestclosed.png", 128 , 128)
	chestClosed.x = withScrn - chestClosed.width 
	chestClosed.y = floor.y - chestClosed.height

	switchOff = display.newImageRect ("images/woodleverup.png", 64, 64)
	switchOff.x = rock.x -10; switchOff.y = rock.y + 10

	myStaticgroup:insert(bush01)
	myStaticgroup:insert(backgroundBush)
	myStaticgroup:insert(bush02)
	myStaticgroup:insert (floor)
	myStaticgroup:insert (rock)
	myStaticgroup:insert (woodSignEnd)
	myStaticgroup:insert (woodSignStart)
	myStaticgroup:insert (chestClosed)
	myStaticgroup:insert (switchOff)

end

function createPipe ()
	pipe = display.newImageRect ("images/barrel128.png", 144, 224)
	pipe.rotation = 90
	physics.addBody(pipe, "static", {density = 1, friction = 0, bounce = 1, isSensor = true  })
	myStaticgroup:insert (pipe)
end

function createRolly ()
	rollybear = display.newImage ("images/rollybear40.png")
	rollybear.myName = "rollybear"
	physics.addBody(rollybear, "dynamic", {density = 1, friction = 0, bounce = 1, isSensor = false, radius = 0})
	rollybear.isBullet = true
	myStaticgroup:insert (rollybear)
	rollybear:toBack()
	
end


function setCoordinates(object, x, y)    
	-- constructor for set Coordinates of a display Object
		object.x = x    object.y = y 
	end






