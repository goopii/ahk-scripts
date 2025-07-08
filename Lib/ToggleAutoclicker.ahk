#Requires AutoHotkey v2.0

autoClicker_on := false

; AutoClicker function
ToggleAutoclicker() {
    global autoClicker_on
    if (autoClicker_on) {
        SetTimer(Click, 0)  ; Disable timer
        ToolTip("", 0, 0, 11)
    } else {
        SetTimer(Click, 50)  ; Click every 50ms
        ToolTip("AUTOCLICKER ON", A_ScreenWidth / 2, 10, 11)
    }
    autoClicker_on := !autoClicker_on
}
