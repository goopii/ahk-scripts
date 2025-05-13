#IfWinActive ahk_class Photoshop
{
MButton::
Send {Space Down}{LButton Down}
Keywait, MButton
Send {LButton Up}{Space Up}
Return

;
;MButton::
;Send {ctrl} {shift} {i}
;Keywait, MButton
;Send {LButton Up}{Space Up}
;Return
}


#IfWinActive ahk_exe illustrator.exe
{

}

if not WinExist("ahk_exe illustrator.exe") or not WinExist("ahk_exe photoshop.exe") {
	;[Alt] + Scroll up
#WheelUp::
	Send, {Media_Next}
return
;[Alt] + Scroll down
#WheelDown::
	Send, {Media_Prev}
return
}