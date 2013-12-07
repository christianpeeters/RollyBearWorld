-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com

-- easy to use variables for screen-positions
centerX = display.contentWidth / 2
centerY = display.contentHeight / 2
withScrn = display.contentWidth
heightScrn = display.contentHeight
topScrn = display.screenOriginY
leftScrn = display.screenOriginX 

backgroundfill = display.newRect(leftScrn, topScrn, withScrn, heightScrn)
gradient = graphics.newGradient(
 { 80, 211, 255 },
  {80, 100, 180 },
  	"up" )
backgroundfill:setFillColor(gradient)

local storyboard = require ("storyboard")
storyboard.purgeOnSceneChange = true

storyboard.gotoScene ( "menu", { effect = "fade"} )