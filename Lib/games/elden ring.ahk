SendMode Input
shiftHeld := False
#IfWinActive, ELDEN RING

	

	;iventory
	Tab::
		Send, {Escape down}
		Sleep, 30
		Send, {Escape up}
	Return

	Enter::
		Send, {e down}
		Sleep, 30
		Send, {e up}
	Return

	;two hand
	*b::
		Send, {e down}
		Send, {LButton down}
		Sleep, 30
		Send, {e up}
		Send, {LButton up}
	Return

	;map
	*m::
		Send, {g down}
		Sleep, 30
		Send, {g up}
	Return

	;Tp to table of grace
	,::
		Send, {f down}
		Sleep, 30
		Send, {r down}
		Sleep, 30
		Send, {e down}
		Sleep, 30
		Sleep, 30
		Send, {f up}
		Send, {r up}
		Send, {e up}
	Return
	 
	;pouch up slot
	*1::
		Send, {e down}
		Send, {f down}
		Sleep, 30
		Send, {e up}
		Send, {f up}
	Return
	;pouch right slot
	*2::
		Send, {e down}
		Send, {x down}
		Sleep, 30
		Send, {e up}
		Send, {x up}
	Return
	;pouch left slot
	*3::
		Send, {e down}
		Send, {z down}
		Sleep, 30
		Send, {e up}
		Send, {z up}
	Return
	;pouch down slot
	*4::
		Send, {e down}
		Send, {r down}
		Sleep, 30
		Send, {e up}
		Send, {r up}
	Return

	

	;makes you dodge on press rather than release
	Space::
		;ToolTip, Space, 10, 10
		Send, {h down}
		Sleep, 30
		Send, {h up}
	Return
	+Space::
		;ToolTip, Shift + Space, 70, 10, 2
		Send, {h up}
		Sleep, 30
		Send, {h down}
		Sleep, 30
		Send, {h up}
		Sleep, 30
	Return

	
	~LShift::
		;ToolTip, Shift held, 10, 10
		shiftHeld := True
		;Send, {h down}
		;Sleep, 100
		While shiftHeld{
			Send, {h down}
			Sleep, 100
		}
	Return
	LShift Up::
		;ToolTip, Shift released, 10, 10
		shiftHeld := False
		Send, {h up}
	Return
