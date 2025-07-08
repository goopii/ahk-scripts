#IfWinActive, LOST ARK
gun := "pistol"
wrongGun := False
pPath := "C:\Users\malte\Desktop\AHK scripts\Lost Ark\Pistol"
sgPath := "C:\Users\malte\Desktop\AHK scripts\Lost Ark\Pistol"
sPath := "C:\Users\malte\Desktop\AHK scripts\Lost Ark\Pistol"
;ToolTip, %gun%, 10, 10

pixelX := 960
pixelY := 980

GunState(img) {
	img := "C:\Users\malte\Desktop\AHK scripts\Lost Ark\Pistol"

	;CoordMode, Pixel
	ImageSearch, imgX, imgY, 0,0, A_ScreenWidth, A_ScreenHeight,  %img%


	ImageSearch, , , 930, 930, 990, 990, %img%

	return ErrorLevel
}


ctrl::
	Send, {F10}
Return

+LButton::
	Send, {g}
Return

^LButton::
	Send, {Escape}
Return

;reset gun
+MButton::
	SoundPlay *-1
	gun := "pistol"
Return

;backward
*XButton1::

	CoordMode, Pixel, Screen
	PixelGetColor, output, pixelX, pixelY, Alt

	ToolTip, ., pixelX, pixelY
	ToolTip, %output%, 400, 600
	;sg 0xE2912d
	;s 0x9E18BF
	;p 0x176EC1
	Switch gun {
		Case pistolC:
			Send, {F8}
		Case sniperC:
		Case shotgunC:
			Send, {F7}
	}
Return

;forward
#if !wrongGun
*XButton2::
	pistolC := [230, 134, 30]
	shotgunC := [40, 139, 227]
	sniperC := [220, 32, 206]
	x := 986
	y := 960
	PixelSearch, , OutputVarY, X1, Y1, X2, Y2, ColorID
	Switch gun {
		Case pistolC:
			Send, {F7}
		Case sniperC:
			Send, {F8}
		Case shotgunC:
	}
Return

*shift::
	Switch gun {
		Case "pistol":
		Case "shotgun":
			Send, {F8}
		Case "sniper":
			Send, {F7}

	}
	gun := "pistol"
	;ToolTip, %gun%, 10, 10
Return

#if gun = "sniper"
*d::

	Send, {d down}
	Sleep, 1400
	Send, {d up}

Return




+XButton2 || XButton1::

Return