;#IfWinActive, LOST ARK

;CoordMode, Pixel, Screen
;CoordMode, ToolTip, Screen

fishX := 960
fishY := 480
fishColor := "0xFFF196"
fishing := False

#MaxThreadsPerHotkey 2
F16::
	fishing := !fishing
	While, fishing {
		ToolTip, %pColor%, 10, 10, 2
		PixelGetColor, pColor, fishX, fishY, RGB
		if (SubStr(pColor, 3, 3) = "FFF") {
            ToolTip, %pColor%, 80, 10, 4
			Random, o1 , 15, 314
			Random, o2 , 15, 314
			Sleep, o1 + o2
			Send, {e}
			Sleep, 6000 + o1
			Send, {e}
		}
		Sleep, 100
	}
Return

#MaxThreadsPerHotkey 2
F5::
	fishing := !fishing
	While, fishing {
		PixelGetColor, pColor, fishX, fishY, RGB
		ToolTip, %pColor%, 10, 10, 2
		PixelSearch, , , fishX, fishY, fishX, fishY, fishColor, 25, RGB
		if (ErrorLevel = 0) {
			Random, o1 , 15, 314
			Random, o2 , 15, 314
			Sleep, o1 + o2
			Send, {e}
			Sleep, 6000 + o1
			Send, {e}
		}
		Sleep, 100
	}
Return

;F6::
;	ToolTip, %pColor%, 960, 100, 3
;Return