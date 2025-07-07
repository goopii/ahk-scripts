#NoTrayIcon
#MaxThreadsPerHotkey 3
#SingleInstance Force

;	ALT + å to ö    
!*sc01A::
	if GetKeyState("Capslock", "T") and !GetKeyState("Shift") or GetKeyState("Shift") and !GetKeyState("Capslock", "T")
		Send, {Ö}
	else
		Send, {ö}
return