 --
-- Abstract: Fishies 2.5D sample app
--
-- Date: September 10, 2010
--
-- Version: 1.0
--
-- File name: main.lua
--
-- Author: Corona Labs
--
-- Demonstrates: graphics, orientation, object touch
--
-- File dependencies: none
--
-- Target devices: Simulator and devices
--
-- Limitations:
--
-- Update History:
--
-- Comments: 
--
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
---------------------------------------------------------------------------------------
require ("loq_util")
local widget = require( "widget" )

display.setStatusBar( display.HiddenStatusBar )

local halfW = display.contentWidth * 0.5
local halfH = display.contentHeight * 0.5
 
local x = display.contentCenterX
local y = display.contentCenterY


_W = display.contentWidth -- Virtual width
_H = display.contentHeight -- Virtual height
_T = display.screenOriginY -- Top
_L = display.screenOriginX -- Left
_R = display.viewableContentWidth - _L -- Right 
_B = display.viewableContentHeight - _T -- Bottom

local shape = display.newRect( x, y, display.contentWidth, display.contentHeight )
shape.fill = { type="camera" }
--shape.anchorX = 0
--shape.anchorY = 0
--local bkgd = display.newImage( "aquariumbackgroundIPhone.jpg" )
--container:insert( bkgd, true ) -- insert and center bkgd

--shape.fill.effect = "filter.sobel"
--shape.fill.effect = "filter.pixelate"
display.setDrawMode( "forceRender" )
-------------------------------------------------------------------------------
---[[
-- Seed randomizer
local seed = os.time();
math.randomseed( seed )

display.setStatusBar( display.HiddenStatusBar )

-- Preload the sound file (theoretically, we should also dispose of it when we are completely done with it)
local soundID = audio.loadSound( "bubble_strong_wav.wav" ) 

-- Background
local halfW = display.viewableContentWidth / 2
local halfH = display.viewableContentHeight / 2



image = display.newImage( "images/img_Backdrop" .. 1 .. ".png", 0,0)
image.anchorX = 0
image.anchorY = 0

OverlayGroup = display.newGroup()
OverlayGroup:insert(image)


local Overlay = 1
local ButtonPress_Overlay = function( event )

	print ("Overlay=" .. Overlay)

 	if image then
 	image:removeSelf()
 	image = nil
 	end

	if Overlay == 0 then
		Overlay = Overlay + 1

		image = display.newImage( "images/img_Backdrop" .. 1 .. ".png", 0,0)
		image.anchorX = 0
		image.anchorY = 0

		ButtonGroup:toFront()
		 
	elseif Overlay == 1 then
		Overlay = Overlay + 1
		image = display.newImage( "images/img_Backdrop" .. 2 .. ".png", 0,0)
		image.anchorX = 0
		image.anchorY = 0

		ButtonGroup:toFront()
	
	elseif Overlay == 2 then

		Overlay = Overlay + 1
		image = display.newImage( "images/img_Backdrop" .. 2 .. ".png", 0,0)
		image.anchorX = 0
		image.anchorY = 0

		ButtonGroup:toFront()


	elseif Overlay == 3 then
		
		Overlay = Overlay + 1
		image = display.newImage( "images/img_Backdrop" .. 3 .. ".png", 0,0)
		image.anchorX = 0
		image.anchorY = 0

		ButtonGroup:toFront()

	elseif Overlay == 4 then
		
		Overlay = Overlay + 1
		image = display.newImage( "images/img_Backdrop" .. 5 .. ".png", 0,0)
		image.anchorX = 0
		image.anchorY = 0

ButtonGroup:toFront()

	elseif Overlay == 5 then
		
		Overlay = Overlay + 1
		image = display.newImage( "images/img_Backdrop" .. 5 .. ".png", 0,0)
		image.anchorX = 0
		image.anchorY = 0
		Overlay = 0

		ButtonGroup:toFront()
	end
	
end

--Runtime:addEventListener( "enterFrame", bounceAnimation );

local centerX = display.contentCenterX
local centerY = display.contentCenterY


local isSimulator = "simulator" == system.getInfo("environment")

if isSimulator then
	msg = display.newText( "Camera fill is not supported on the simulator", centerX, 80, "Verdana-Bold", 12 )
	msg:setFillColor( 0, 0, 1 )
end



local filterIndex = 0
local ButtonPress_Effects = function( event )
	
	if filterIndex == 0 then
		filterIndex = filterIndex + 1
		shape.fill.effect = "filter.sobel"
	elseif filterIndex == 1 then
		filterIndex = filterIndex + 1
		shape.fill.effect = "filter.pixelate"
	elseif filterIndex == 2 then
		shape.fill.effect = "filter.sepia"
		filterIndex = filterIndex + 1
	elseif filterIndex == 3 then
		shape.fill.effect = nil
		filterIndex = 0
	end
	
end

local ButtonPress_Menu = function( event )

print ("Btn_Menu")

 	if image then
 	image:removeSelf()
 	image = nil
 	end
	
end


local ButtonPress_Photo = function( event )

ButtonGroup.isVisible = false

picture = display.captureScreen( )
picture.x = halfW
picture.y = halfH
atrace (picture)

media.save( picture , system.TemporaryDirectory )

flash = display.newRect( 0, 0, display.contentWidth, display.contentHeight )

flash.anchorX, flash.anchorY = 0,0
flash.x, flash.y = 0,000
	

local PhotoTaken= function( obj )

flash:removeSelf( )
flash = nil

picture:removeSelf()
flash = nil

ButtonGroup.isVisible = true

end

transition.to( flash, { time=200, alpha=0, onComplete=PhotoTaken } )
transition.to( picture, { time=180, x=0, y=0, xScale=.10, yScale=10} )
end

-- "Remove Default" Button
Btn_Effects = widget.newButton
{
	defaultFile = "images/Btn_Effects_up.png",
	overFile = "images/Btn_Effects_down.png",
	label = " ",
	labelColor = 
	{ 
		default = { 1, 1, 1 }, 
	},
	fontSize = 18,
	emboss = true,
	onPress = ButtonPress_Effects,
}
Btn_Effects.x = display.contentCenterX


Btn_Menu = widget.newButton
{
	defaultFile = "images/Btn_Menu_up.png",
	overFile = "images/Btn_Menu_down.png",
	label = " ",
	labelColor = 
	{ 
		default = { 1, 1, 1 }, 
	},
	fontSize = 18,
	emboss = true,
	onPress = ButtonPress_Menu,
}
Btn_Menu.x = display.contentCenterX


Btn_Overlay = widget.newButton
{
	defaultFile = "images/Btn_Overlay_up.png",
	overFile = "images/Btn_Overlay_down.png",
	label = " ",
	labelColor = 
	{ 
		default = { 1, 1, 1 }, 
	},
	fontSize = 18,
	emboss = true,
	onPress = ButtonPress_Overlay,
}



Btn_Overlay.x = display.contentCenterX

Btn_Photo = widget.newButton
{
	defaultFile = "images/Btn_Photo_up.png",
	overFile = "images/Btn_Photo_down.png",
	label = " ",
	labelColor = 
	{ 
		default = { 1, 1, 1 }, 
	},
	fontSize = 18,
	emboss = true,
	onPress = ButtonPress_Photo,
}
Btn_Photo.x = display.contentCenterX


Btn_Overlay.xScale = 1
Btn_Overlay.yScale = 1

Btn_Menu.xScale = 1
Btn_Menu.yScale = 1

Btn_Effects.xScale = 1
Btn_Effects.yScale = 1

Btn_Photo.xScale = 1
Btn_Photo.yScale = 1

--

ButtonGroup= display.newGroup()
ButtonGroup:insert(Btn_Menu)
ButtonGroup:insert(Btn_Photo)	
ButtonGroup:insert(Btn_Effects)
ButtonGroup:insert(Btn_Overlay)
ButtonGroup:toFront( )

Btn_Overlay.anchorX = 1
Btn_Overlay.anchorY = 0

Btn_Menu.anchorX = 1
Btn_Menu.anchorY = 0

Btn_Photo.anchorX = 1
Btn_Photo.anchorY = 0

Btn_Effects.anchorX = 1
Btn_Effects.anchorY = 0

Btn_Overlay.x = _L + (Btn_Overlay.width * 1 + (Btn_Overlay.width *.2)  )
Btn_Overlay.y= _B - (Btn_Overlay.height * 2 )

Btn_Menu.x = _L + (Btn_Menu.width * 2 + (Btn_Menu.width * .4) )
Btn_Menu.y = _B - (Btn_Menu.height * 2 )

Btn_Effects.x = _L + (Btn_Effects.width * 3 + (Btn_Effects.width * .6) )
Btn_Effects.y= _B - (Btn_Menu.height * 2 )

Btn_Photo.x = _L + (Btn_Photo.width * 4 + (Btn_Photo.width * .8) )
Btn_Photo.y = _B - (Btn_Menu.height * 2 )


-- This function is never called, 
-- but shows how we would unload the sound if we wanted to
function unloadSound()
	audio.dispose(soundID)
	soundID = nil
end

--]]