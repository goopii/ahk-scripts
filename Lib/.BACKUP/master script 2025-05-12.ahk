;==============================================================================
; SCRIPT SETTINGS
;==============================================================================
#MaxThreadsPerHotkey 1
#SingleInstance Force
#Requires AutoHotkey v2.0
A_MenuMaskKey := "vkE8"

#include utils/gui_log.ahk
#include utils/IsLaptop.ahk
#include utils/IsFullscreen.ahk
#include utils/GetActiveMonitor.ahk
#include utils/mouseOverTaskbar.ahk
#include utils/SendHelpers.ahk
#include utils/ToggleAutoclicker.ahk
#include utils/RestartScript.ahk

;==============================================================================
; GLOBAL VARIABLES
;==============================================================================
autoClicker_on := false     
is_laptop := false
is_WindowsKey_Held := false
; Border GUI
gui_border := Gui()
gui_border.Opt("+AlwaysOnTop -Caption +ToolWindow E0x20")
gui_border_on := false
;==============================================================================
; HELPER FUNCTIONS
;==============================================================================
; Check if system is a laptop by detecting battery presence
IsLaptop() {
    ; Get system power status
    try {
        battery := ComObject("WbemScripting.SWbemLocator").ConnectServer().ExecQuery(
            "Select * from Win32_Battery"
        )

        ; If any battery is found, it's a laptop
        for _ in battery {
            return true
        }
    } catch Error {
        ; If COM object creation fails, fallback to checking power status
        DllCall("kernel32.dll\GetSystemPowerStatus", "Ptr", Buffer(12))
        return DllCall("kernel32.dll\GetSystemPowerStatus", "Ptr", Buffer(12)) != 0
    }

    return false
}
; Get device-specific value based on system type
GetDeviceValue(desktopValue, laptopValue) {
    global is_laptop
    return is_laptop ? laptopValue : desktopValue
}
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
SendModded(key, modifiers := []) {
    ; Build modifier string
    modString := ""
    for mod in modifiers {
        switch mod {
            case "alt":
                if GetKeyState("Alt", "P") {
                    modString .= "!"
                }
            case "shift":
                if GetKeyState("Shift", "P") {
                    modString .= "+"
                }
            case "ctrl":
                if GetKeyState("Control", "P") {
                    modString .= "^"
                }
            case "win":
                if (GetKeyState("LWin", "P") or GetKeyState("RWin", "P")) {
                    modString .= "#"
                }
        }
    }
    Send(modString key)
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
GuiBorderToggle(show, color := "") {
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
        ; MsgBox("BackColor: " gui_border.BackColor " `nColor: " color)
        if color != "" { ; If a color is provided, use it
            gui_border.BackColor := color
        }
        else If gui_border.BackColor == "" { ; If no previous color exists, use white
            gui_border.BackColor := "FFFFFF"
        }
        ; Otherwise keep the existing color
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
                    GuiBorderToggle(true)
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
;==============================================================================
; SCRIPT INITIALIZATION
;==============================================================================
log_setState(true)
; Check if system is a laptop or desktop
is_laptop := IsLaptop()
; Show border on startup
; GuiBorderToggle(true, "2176d6")
; Log intialization
; log_Init()
; Setup quick reload on save in vscode
; #HotIf WinActive("ahk_exe Code.exe")
#HotIf WinActive("ahk_exe Cursor.exe")
; #HotIfWinActive "ahk_exe Cursor.exe"

~^s:: {
    ; Get the title of the active window
    activeTitle := WinGetTitle("A")
    ; Check if the active file matches the script name
    if (InStr(activeTitle, A_ScriptName)) {
        Sleep(100)  ; Small delay to ensure save completes
        RestartScript()
    }
}
#HotIf
;==============================================================================
; Windows key MODIFIER COMBINATIONS
;==============================================================================
*$LWin:: {
    global is_WindowsKey_Held
    ; GuiBorderToggle(false)
    Send("{LWin DownTemp}")
    ; WindowsKey_Mode is true initially
    is_WindowsKey_Held := true
    ; Wait for key release
    KeyWait("LWin")
    is_WindowsKey_Held := false
    Send ("{LWin up}")
}
#HotIf is_WindowsKey_Held
; backtick{`} and tilde{∼}
*Esc:: {
    if GetKeyState("Shift", "P") { ; {`}
        SendModded("{U+223C}", ["alt", "ctrl"])  ; Ignore everything except Alt and Ctrl
    }
    else { ; {∼}
        SendModded("{U+0060}", ["alt", "ctrl"])  ; Ignore everything except Alt and Ctrl
    }
}
h::{ 
    KeyHistory
}
z:: {
    Send("{LWin}")
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
;==============================================================================
; MOUSE MODIFICATIONS
;==============================================================================
; Middle-click on taskbar to close window
#HotIf mouseOverTaskbar()
MButton Up:: {
    Click("Right")
    Sleep(GetDeviceValue(150, 500))
    Send("{Up}{Enter}")
}
#HotIf

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
; KEY REMAPPINGS
;==============================================================================
; Swap + and = keys. If + is pressed, send = and vice versa
$*=:: {
    if GetKeyState("Shift", "P") {
        SendModded("{=}", ["alt", "ctrl"])  ; Include only Alt and Ctrl
    }
    else {
        SendModded("{+}", ["alt", "ctrl"])  ; Include only Alt and Ctrl
    }
}

; Zen.exe specific hotkeys
#HotIf WinActive("ahk_exe zen.exe")
!w:: {
    log("Zen.exe: Alt+W -> Ctrl+Tab")
    SendModded("{Tab}", ["ctrl"])  ; Alt+W sends Ctrl+Tab
}
!s:: {
    log("Zen.exe: Alt+S -> Shift+Ctrl+Tab")
    SendModded("{Tab}", ["shift", "ctrl"])   ; Alt+S sends Shift+Ctrl+Tab
}
#HotIf

;==============================================================================
; DESKTOP SPECIFIC CHARACTER MAPPINGS
;==============================================================================
#HotIf is_WindowsKey_Held and !is_laptop
; and !is_laptop This doesnt work for some reason
; Nordic characters under Windows key mode (desktop only)
*sc01A:: SendCase("{Å}", "{å}")  ; {[}
*sc028:: SendCase("{Ä}", "{ä}")  ; {'}
*sc027:: SendCase("{Ö}", "{ö}")  ; {;}
#HotIf
;==============================================================================
; LAPTOP SPECIFIC MODIFICATIONS
;==============================================================================
#HotIf is_laptop
; Media controls on laptop
End::Media_Play_Pause
Insert::Media_Next
Home::Media_Prev

PgUp:: return
PgDn:: return

^PgUp::XButton1
^PgDn::XButton2
#HotIf
