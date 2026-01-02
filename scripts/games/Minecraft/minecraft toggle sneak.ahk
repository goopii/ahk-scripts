#SingleInstance, force
{

#IfWinActive ahk_exe javaw.exe
{
sneak := False

*$c::
sneak := !sneak
ToolTip, SNEAK: %sneak%, 10, 10
if (sneak) {
    SendInput, {LCtrl down}
} else {
    SendInput, {LCtrl up}
}
return

; *$LCtrl::
; if (not sneak) {
;     SendInput, {LCtrl up }
;     sneak := !sneak
;     ToolTip, SNEAK: %sneak%, 10, 10
; }
; else {
;     SendInput, {LCtrl down}
; }
; return
}
}