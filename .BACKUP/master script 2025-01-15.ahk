;==============================================================================
; SCRIPT SETTINGS
;==============================================================================
#NoTrayIcon
#MaxThreadsPerHotkey 3
#SingleInstance Force
#Requires AutoHotkey v2.0
;==============================================================================
; GLOBAL VARIABLES
;==============================================================================
autoClicker_on := false
; F20 variables
F20_Mode := false
F20_PrevTick := 0
F20_DoubleTapWindow := 400 ;ms
; Green border GUI
gui_GreenBorder := Gui()
gui_GreenBorder.Opt("+AlwaysOnTop -Caption +ToolWindow E0x20")  
gui_GreenBorder.BackColor := "00FF00"
gui_GreenBorder_on := false
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
    
    Loop MonitorGetCount() {
        MonitorGet(A_Index, &L, &T, &R, &B)
        if (winCenterX >= L && winCenterX <= R && winCenterY >= T && winCenterY <= B)
            return {x: L, y: T, w: R-L, h: B-T}
    }
    return false
}
; Send a key with modifiers
SendModded(key, skipAlt := false, skipShift := false, skipCtrl := false) {
    modifiers := ""
    if GetKeyState("Alt", "P") and !skipAlt
        modifiers .= "!"
    if GetKeyState("Shift", "P") and !skipShift
        modifiers .= "+"
    if GetKeyState("Control", "P") and !skipCtrl
        modifiers .= "^"
    
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
        ToolTip("AUTOCLICKER ON", A_ScreenWidth/2, 10, 11)
    }
    autoClicker_on := !autoClicker_on
}
; Restarts script for debugging
RestartScript() {
    if A_IsCompiled
        Run(A_ScriptFullPath)
    else
        Run(Format('"{1}" "{2}"', A_AhkPath, A_ScriptFullPath))
    ExitApp
}
;==============================================================================
; GUI FUNCTIONS
;==============================================================================
GreenBorder(show) {
    static borderWidth := 4
    global gui_GreenBorder_on
    
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
            monitor.w-borderWidth, borderWidth,
            monitor.w-borderWidth, monitor.h-borderWidth,
            borderWidth, monitor.h-borderWidth,
            borderWidth, borderWidth)
            
        ; Show GUI and apply region
        gui_GreenBorder.Show(Format("x{1} y{2} w{3} h{4} NoActivate", 
            monitor.x, monitor.y, monitor.w, monitor.h))
        WinSetRegion(region, gui_GreenBorder)
        gui_GreenBorder_on := true
        
        ; Monitor active window changes in a separate thread to update border
        SetTimer(MonitorActiveWindow, -1)
    } else {
        gui_GreenBorder.Hide()
        gui_GreenBorder_on := false
    }
}
MonitorActiveWindow() {
    static prevWin := ""
    
    while (gui_GreenBorder_on) {
        activeWin := WinGetID("A")
        if (activeWin != prevWin) {
            GreenBorder(true)
            prevWin := activeWin
        }
        WinWaitNotActive(activeWin)
    }
}
;==============================================================================
; F20 MODIFIER COMBINATIONS
;==============================================================================
F20:: {
    global F20_Mode, F20_PrevTick, F20_DoubleTapWindow
    ; Get time since last F20 press
    currentTick := A_TickCount
    F20Delta := currentTick - F20_PrevTick
    F20_PrevTick := currentTick
    
    ; F20Mode is true initially
    F20_Mode := true
    
    ; Wait for key release
    KeyWait("F20")
    
    if (F20Delta <= F20_DoubleTapWindow) {
        ; If time between taps is less than the double tap window, keep F20 mode on
        GreenBorder(true)
    } else {
        ; If time between taps is greater than the double tap window, turn off F20 mode
        F20_Mode := false
        GreenBorder(false)
    }
}

#HotIf F20_Mode
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
*+:: SendModded("{F12}")

; Media controls
\:: Send("{Media_Play_Pause}")
MButton:: Send("{Media_Play_Pause}")
WheelDown:: Send("{Media_Prev}")
[:: Send("{Media_Prev}")
WheelUp:: Send("{Media_Next}")
]:: Send("{Media_Next}")

; Autoclicker
XButton2:: ToggleAutoclicker()
; Emoji menu
.:: {
    Send("{LWin Down}{.}{LWin Up}")
}
; Clipboard history
v:: {
    Send("{LWin Down}{v}{LWin Up}")
}
; Restart script
^r:: RestartScript()
#HotIf
;==============================================================================
; MOUSE MODIFICATIONS
;==============================================================================
^MButton:: {  ; [Ctrl] + middle click
    if not IsFullscreen() {
        Send("{Delete}")
    }
}
+MButton:: {  ; [Shift] + middle click
    if not IsFullscreen() {
        Send("{Enter}")
    }
}
;==============================================================================
; CHARACTER REPLACEMENTS (Alt + key)
;==============================================================================
; Nordic characters
!*sc01A:: SendCase("{Å}", "{å}")  ; {[}
!*sc028:: SendCase("{Ä}", "{ä}")  ; {'}
!*sc027:: SendCase("{Ö}", "{ö}")  ; {;}
; Accented characters
!*e:: SendCase("{É}", "{é}")
!*u:: SendCase("{Ü}", "{ü}")
!*i:: SendCase("{Ï}", "{ï}")
;==============================================================================
; KEY REMAPPINGS AND NAVIGATION
;==============================================================================
; Swap + and = keys. If + is pressed, send = and vice versa
$*=:: {
    if GetKeyState("Shift", "P")
        SendModded("{=}", false, true, false)
    else
        SendModded("{+}", false, true, false)
}