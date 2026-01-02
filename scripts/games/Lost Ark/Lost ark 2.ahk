	CoordMode, Pixel, Screen
	CoordMode, ToolTip, Screen
	SendMode Input


	raidMode := False

	gunX := 960
	gunY := 980
	shotgunC := "0xE2912D"
	sniperC := "0x9E18BF"
	pistolC := "0x176EC1"

	currentGun := "pistol"
	;ToolTip, %currentGun%, 10, 10
#IfWinActive, LOST ARK

	ctrl::
		Send, {F10}
	Return

	MButton::
		Send, {F11}
	Return

	+LButton::
		Send, {g}
	Return

	!LButton::
		Send, {Alt down}
		Send, {LButton}
		Send, {Enter}
		Send, {Alt up}
	Return
	^!LButton::
		Send, {Escape}
	Return

	F6::
		raidMode := !raidMode
		ToolTip, %raidMode%, 10, 10, 1
	Return

	;F7
	;Right

	;forward
	;Shotgun
	XButton2::
		;ToolTip, %currentGun%, 10, 10
		
		CoordMode, Pixel, Screen
		PixelGetColor, pColor, gunX, gunY

		Switch pColor {
			Case shotgunC:
				Send, {F8}
				currentGun := "pistol"
			Case pistolC:
				Send, {F7}
				currentGun := "shotgun"
			Case sniperC:
				Send, {F7}
				currentGun := "pistol"
			Default:
				currentGun := ""
		}

	Return



	;F8
	;Left

	;backwards
	;Sniper
	XButton1::
		;ToolTip, %currentGun%, 10, 10

		CoordMode, Pixel, Screen
		PixelGetColor, pColor, gunX, gunY

		Switch pColor {
			Case shotgunC:
				Send, {F7}
				currentGun := "sniper"
			Case pistolC:
				Send, {F8}
				currentGun := "sniper"
			Case sniperC:
				Send, {F7}
				currentGun := "pistol"
		}
	Return

	#if currentGun = "sniper"
	*q::
		Send, {a}
	Return
	*w::
		Send, {s}
	Return
	*e::
	*d::
		Send, {d down}
		Sleep, 1300
		Send, {d up}
	Return
	
	#if raidMode
	*`::
		Send, {7}
	Return

	*1::
		Send, {8}
	Return

	*2::
		Send, {9}
	Return

	*3::
		Send, {0}
	Return


