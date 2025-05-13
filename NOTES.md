; the F20 hotkey is meant to have two discreet ways of activating F20Mode:
; 1. Temporarily activated while held:
; * If F20 is held, F20Mode is True
; * When F20 is released, F20Mode is False
; 1. Toggled on or off:
; * If F20 is pressed twice within 400ms and, F20Mode is toggled on or off
; * Show a tooltip to indicate the current state: ToolTip(F20Mode ? "F20 MODE" : "", A_ScreenWidth/2, 30)

; F20Timer handles the transition between hold and toggle modes
; If F20 is still held after 400ms, we assume the user wants to hold the key
; rather than perform a double-tap toggle
F20Timer() {
    global F20Held, F20Mode
    if (F20Held) {
        F20Mode := true  ; Enter hold mode
        ToolTip("F20 MODE", A_ScreenWidth/2, 30)
    }
    F20Held := false    ; Reset the held state
}

; F20 can be either held down for temporary activation
; or double-tapped to toggle the mode on/off
$F20:: {
    global F20Mode, F20Held
    if (F20Held) {
        ; Second press detected within 400ms - toggle mode
        F20Held := false
        F20Mode := !F20Mode  ; Toggle F20Mode on/off
    } else {
        ; First press - start timer to check for second press
        F20Held := true
        SetTimer(F20Timer, 400)  ; Wait 400ms for potential second press
    }
    if (!F20Mode) {
        ToolTip("", A_ScreenWidth/2, 30)  ; Clear tooltip when mode is off
    }
}