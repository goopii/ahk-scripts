;==============================================================================
; SCRIPT SETTINGS
;==============================================================================
; InstallKeybdHook(false, true)  ; Install keyboard hook with default settings
#MaxThreadsPerHotkey 3
#SingleInstance Force
#Requires AutoHotkey v2.0
A_MenuMaskKey := "vkE8"
;==============================================================================
; GLOBAL VARIABLES
;==============================================================================
autoClicker_on := false
; Windows key variables
is_WindowsKey_Held := false
WindowsKey_Delta := 0
WindowsKey_HeldTime := 0
WindowsKey_PrevTick := 0
WindowsKey_DoubleTapWindow := 400 ;ms
WindowsKey_SingleTapWindow := 150 ;ms
; Border GUI
gui_border := Gui()
gui_border.Opt("+AlwaysOnTop -Caption +ToolWindow E0x20")
gui_border_on := false
; Show border on startup
GuiBorderToggle(true, "ff0000")
;==============================================================================
; HELPER FUNCTIONS
;==============================================================================
; Check if active window is fullscreen
IsFullscreen() {
    WinGetPos &X, &Y, &W, &H, "A"
    return (X == 0 and Y == 0 and W == A_ScreenWidth and H == A_ScreenHeight)
}
; Get active monitor dimensions
GetActiveMonitor() {
    WinGetPos(&winX, &winY, &winW, &winH, "A")
    winCenterX := winX + (winW / 2)
    winCenterY := winY + (winH / 2)

    loop MonitorGetCount() {
        MonitorGet(A_Index, &L, &T, &R, &B)
        if (winCenterX >= L && winCenterX <= R && winCenterY >= T && winCenterY <= B)
            return { x: L, y: T, w: R - L, h: B - T }
    }
    return false
}
; Check if mouse is over taskbar
mouseOverTaskbar() {
    CoordMode("Mouse", "Screen")  ; Set coordinate mode to screen

    mousePos := MouseGetPos(&mouseX, &mouseY, &mouseWin, &mouseControl)

    ; Check for main taskbar
    if WinExist("ahk_class Shell_TrayWnd") {
        WinGetPos(&taskX, &taskY, &taskW, &taskH, "ahk_class Shell_TrayWnd")
        if (mouseX >= taskX && mouseX < taskX + taskW
            && mouseY >= taskY && mouseY < taskY + taskH) {
            return true
        }
    }
    return false
}
; Send a key with modifiers
SendModded(key, skipAlt := false, skipShift := false, skipCtrl := false, skipWindows := true) {
    modifiers := ""
    if GetKeyState("Alt", "P") and !skipAlt
        modifiers .= "!"
    if GetKeyState("Shift", "P") and !skipShift
        modifiers .= "+"
    if GetKeyState("Control", "P") and !skipCtrl
        modifiers .= "^"
    if (GetKeyState("LWin", "P") or GetKeyState("LWin", "P")) and !skipWindows
        modifiers .= "#"

    ; ToolTip(modifiers key, 10, 10, 11)
    Send(modifiers key)
}
; Send a character with case sensitivity
SendCase(upperChar, lowerChar) {
    isUpper := GetKeyState("Capslock", "T") != GetKeyState("Shift")
    Send(isUpper ? upperChar : lowerChar)
}
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
; Restarts script for debugging
RestartScript() {
    try {
        if A_IsCompiled
            Run(A_ScriptFullPath)
        else
            Run(Format('"{1}" "{2}"', A_AhkPath, A_ScriptFullPath))
        ExitApp  ; Only exit if Run was successful
    } catch Error as e {
        MsgBox("Failed to restart script: " e.Message, "Restart Error", "Icon!")
        return false  ; Return false to indicate restart failed
    }
    return true  ; Should never reach here, but good practice
}
;==============================================================================
; GUI FUNCTIONS
;==============================================================================
GuiBorderToggle(show, color := "FFFFFF") {
    static borderWidth := 4
    global gui_border_on

    if (show) {
        ; Get monitor dimensions
        monitor := GetActiveMonitor()
        if (!monitor) {
            return
        }
        ; Create region string for border frame
        region := Format("0-0 {1}-{2} {3}-{4} {5}-{6} {7}-{8} {9}-{10}",
            monitor.w, 0, monitor.w, monitor.h, 0, monitor.h, 0, 0,
            borderWidth, borderWidth)
        region .= Format(" {1}-{2} {3}-{4} {5}-{6} {7}-{8}",
            monitor.w - borderWidth, borderWidth,
            monitor.w - borderWidth, monitor.h - borderWidth,
            borderWidth, monitor.h - borderWidth,
            borderWidth, borderWidth)

        ; Show GUI and apply region
        gui_border.BackColor := color
        gui_border.Show(Format("x{1} y{2} w{3} h{4} NoActivate",
            monitor.x, monitor.y, monitor.w, monitor.h))
        WinSetRegion(region, gui_border)
        gui_border_on := true
        ; Monitor active window changes in a separate thread to update border
        SetTimer(MonitorActiveWindow, -1)
    } else {
        gui_border.Hide()
        gui_border_on := false
    }
}
MonitorActiveWindow() {
    static prevWin := ""

    while (gui_border_on) {
        try {
            if activeWin := WinGetID("A") {
                if (activeWin != prevWin) {
                    GuiBorderToggle(true, "00FF00")
                    prevWin := activeWin
                }
                WinWaitNotActive(activeWin)
            }
        } catch Error as e {
            ; Skip this iteration if window detection fails
            continue
        }
    }
}

*LWin:: {
    Send("{LWin DownR}")
    ;=======================================
    global is_WindowsKey_Held, WindowsKey_HeldTime, WindowsKey_PrevTick, WindowsKey_DoubleTapWindow,
        WindowsKey_SingleTapWindow, WindowsKey_Delta
    ; WindowsKey_Mode is true initially
    is_WindowsKey_Held := true

    ; Get time since last Windows key press.u
    currentTick := A_TickCount
    if (currentTick <= 100) {

    } else {

    }
    WindowsKey_Delta := currentTick - WindowsKey_PrevTick
    WindowsKey_PrevTick := currentTick

    ToolTip(WindowsKey_Delta "`n" WindowsKey_PrevTick "`n" WindowsKey_HeldTime "`n", 10, 10, 11)

    ; Wait for key release
    KeyWait("LWin")
    WindowsKey_HeldTime := A_TickCount - WindowsKey_PrevTick

    ToolTip(WindowsKey_Delta "`n" WindowsKey_PrevTick "`n" WindowsKey_HeldTime "`n", 100, 10, 12)

    if (WindowsKey_Delta <= WindowsKey_DoubleTapWindow) {
        ; If time between taps is less than the double tap window, keep Windows key mode on
        GuiBorderToggle(true, "00FF00")
    } else {
        ; If time between taps is greater than the double tap window, turn off Windows key mode
        is_WindowsKey_Held := false
        GuiBorderToggle(false)
        if (WindowsKey_HeldTime <= WindowsKey_SingleTapWindow) {
            ; Send("{LWin}")
        }
    }
    Send("{LWin Up}")
}

#UseHook False

#HotIf is_WindowsKey_Held
*u:: {
    KeyHistory
}
; Arrow key navigation
*w:: SendModded("{Up}")
*a:: SendModded("{Left}")
*s:: SendModded("{Down}")
*d:: SendModded("{Right}")
; Function keys
*1:: SendModded("{F1}")
*2:: SendModded("{F2}")
*3:: SendModded("{F3}")
*4:: SendModded("{F4}")
*5:: SendModded("{F5}")
*6:: SendModded("{F6}")
*7:: SendModded("{F7}")
*8:: SendModded("{F8}")
*9:: SendModded("{F9}")
*0:: SendModded("{F10}")
*-:: SendModded("{F11}")
*=:: SendModded("{F12}")
; Media controls
\:: Send("{Media_Play_Pause}")
MButton:: Send("{Media_Play_Pause}")
WheelDown:: Send("{Media_Prev}")
[:: Send("{Media_Prev}")
WheelUp:: Send("{Media_Next}")
]:: Send("{Media_Next}")
; Autoclicker
XButton2:: ToggleAutoclicker()
; Restart script
^r:: {
    WindowsKey_Mode := false
    RestartScript()
}
#HotIf