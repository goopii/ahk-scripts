#IfWinActive, LOST ARK
gun := "pistol"
;ToolTip, %gun%, 10, 10


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
	Switch gun {
		Case "pistol":
			Send, {F8}
		Case "sniper":
		Case "shotgun":
			Send, {F7}
	}
	gun := "sniper"
	;ToolTip, %gun%, 10, 10
Return

;forward
*XButton2::
	Switch gun {
		Case "pistol":
			Send, {F7}			
		Case "shotgun":
		Case "sniper":
			Send, {F8}
	}
	gun := "shotgun"
	;ToolTip, %gun%, 10, 10
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


*d::
	Switch gun {
		Case "pistol", "shotgun":
			Send, {d}
		Case "sniper":
			Send, {d down}
			Sleep, 1400
			Send, {d up}
	}
Return