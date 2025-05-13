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
#include utils/MouseOverTaskbar.ahk
#include utils/SendCase.ahk
#include utils/SendModded.ahk
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
    Send("{LWin up}")
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
    KeyHistory()
}
z:: {
    Send("{LWin}")
}
; Arrow key navigation
*w:: SendModded("{Up}", ["all", "-win"]) log("w")
*a:: SendModded("{Left}", ["all", "-win"]) log("a")
*s:: SendModded("{Down}", ["all", "-win"]) log("s")
*d:: SendModded("{Right}", ["all", "-win"]) log("d")
; Function keys
*1:: SendModded("{F1}", ["all", "-win"])
*2:: SendModded("{F2}", ["all", "-win"])
*3:: SendModded("{F3}", ["all", "-win"])
*4:: SendModded("{F4}", ["all", "-win"])
*5:: SendModded("{F5}", ["all", "-win"])
*6:: SendModded("{F6}", ["all", "-win"])
*7:: SendModded("{F7}", ["all", "-win"])
*8:: SendModded("{F8}", ["all", "-win"])
*9:: SendModded("{F9}", ["all", "-win"])
*0:: SendModded("{F10}", ["all", "-win"])
*-:: SendModded("{F11}", ["all", "-win"])
*=:: SendModded("{F12}", ["all", "-win"])
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
