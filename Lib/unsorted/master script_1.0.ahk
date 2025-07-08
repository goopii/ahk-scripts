#NoTrayIcon
#MaxThreadsPerHotkey 3
#SingleInstance Force

IsFullscreen() {
    WinGetPos, X, Y, W, H, A
    return (X != 0 or Y != 0 or W != A_ScreenWidth or H != A_ScreenHeight)
}

;Autoclicker 
;[windows] + forward
#XButton2::
	toggle := !toggle
	if (toggle) {
		ToolTip, AUTOCLICKER ON, A_ScreenWidth/2, 10
	}
	else{
		ToolTip,
	}
	Loop
	{
		If (!toggle)
			Break
		Click
		Sleep 50 ; Make this number higher for slower clicks, lower for faster.
	}
return

;Disables the winows key while allowing modifiers
~LWin::Send {vkE8}

;with volumeknob bound to insert:
Insert::
	Send, {Media_Play_Pause}
return

;[Windows] + middleclick
#MButton::
	Send, {Media_Play_Pause}
return

;[Windows] + Scroll up
#WheelUp::
	Send, {Media_Next}
return

;[Windows] + Scroll down
#WheelDown::
	Send, {Media_Prev}
return

;[ctrl] + middleclick
$^MButton::
    if (IsFullscreen()) {
		Send, {Delete}
	}
return

;[shift] + middleclick
$+MButton::
    if (IsFullscreen()) {
		Send, {Enter}
	}
return

;UP/[ to å 
!*sc01A::
	if GetKeyState("Capslock", "T") and !GetKeyState("Shift") or GetKeyState("Shift") and !GetKeyState("Capslock", "T")
		Send, {Å}
	else
		Send, {å}
return

;RIGHT/' to ä
!*sc028::
	if GetKeyState("Capslock", "T") and !GetKeyState("Shift") or GetKeyState("Shift") and !GetKeyState("Capslock", "T")
		Send, {Ä}
	else
		Send, {ä}
return

;LEFT/; to ö
!*sc027::
	if GetKeyState("Capslock", "T") and !GetKeyState("Shift") or GetKeyState("Shift") and !GetKeyState("Capslock", "T")
		Send, {Ö}
	else
		Send, {ö}
return

;[alt] + e to é
!*e::
	if GetKeyState("Capslock", "T") and !GetKeyState("Shift") or GetKeyState("Shift") and !GetKeyState("Capslock", "T")
		Send, {É}
	else
		Send, {é}
return

;[alt] + u to ü
!*u::
	if GetKeyState("Capslock", "T") and !GetKeyState("Shift") or GetKeyState("Shift") and !GetKeyState("Capslock", "T")
		Send, {Ü}
	else
		Send, {ü}
return

;[alt] + i to ï
!*i::
	if GetKeyState("Capslock", "T") and !GetKeyState("Shift") or GetKeyState("Shift") and !GetKeyState("Capslock", "T")
		Send, {Ï}
	else
		Send, {ï}
return

;swaps + and =
$*=::
if GetKeyState("Shift")
		Send, {=}
	else
		Send, {+}
return

; [Alt] + W for Up Arrow
!*w::
    Send, {Up}
return

; [Alt] + Shift + W for Up Arrow with Shift (select text upward)
+!*w::
    Send, +{Up}
return

; [Alt] + A for Left Arrow
!*a::
    Send, {Left}
return

; [Alt] + Shift + A for Left Arrow with Shift (select text to the left)
+!*a::
    Send, +{Left}
return

; [Alt] + S for Down Arrow
!*s::
    Send, {Down}
return

; [Alt] + Shift + S for Down Arrow with Shift (select text downward)
+!*s::
    Send, +{Down}
return

; [Alt] + D for Right Arrow
!*d::
    Send, {Right}
return

; [Alt] + Shift + D for Right Arrow with Shift (select text to the right)
+!*d::
    Send, +{Right}
return


