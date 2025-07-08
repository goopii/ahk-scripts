#MaxThreadsPerHotkey 1
#SingleInstance Force
#Requires AutoHotkey v2.0
A_MenuMaskKey := "vkE8"
;==============================================================================
; INCLUDES
;==============================================================================
#include core/Hotkeys.ahk
#include core/HotkeysMouse.ahk
#include core/HotkeysApp.ahk

#include utils/HotReload.ahk
#include utils/gui/gui_log.ahk
#include utils/IsLaptop.ahk
#include utils/IsFullscreen.ahk
#include utils/GetActiveMonitor.ahk
#include utils/MouseOverTaskbar.ahk
#include utils/SendCase.ahk
#include utils/SendModded.ahk
#include utils/ToggleAutoclicker.ahk
;==============================================================================
; INITIALIZATION
;==============================================================================
is_WindowsKey_Held := false
LogState(false)
;==============================================================================
; MAIN
;==============================================================================
*$LWin:: {
    global is_WindowsKey_Held
    is_WindowsKey_Held := true
    Send("{LWin DownTemp}")
    ; Wait for key release
    KeyWait("LWin")
    is_WindowsKey_Held := false
    Send("{LWin up}")
}
#HotIf is_WindowsKey_Held
; backtick{`} and tilde{∼}
*Esc:: {
    if GetKeyState("Shift", "P") { ; {`}
        SendModded("{U+223C}", ["alt", "ctrl"])
    }
    else { ; {∼}
        SendModded("{U+0060}", ["alt", "ctrl"])
    }
}
#!l:: {
    LogState("toggle")
    LogDisplay("toggle")
}
; Arrow key navigation
*w:: SendModded("{Up}", ["-win"])
*a:: SendModded("{Left}", ["-win"])
*s:: SendModded("{Down}", ["-win"])
*d:: SendModded("{Right}", ["-win"])
; Function keys
*1:: SendModded("{F1}", ["-win"])
*2:: SendModded("{F2}", ["-win"])
*3:: SendModded("{F3}", ["-win"])
*4:: SendModded("{F4}", ["-win"])
*5:: SendModded("{F5}", ["-win"])
*6:: SendModded("{F6}", ["-win"])
*7:: SendModded("{F7}", ["-win"])
*8:: SendModded("{F8}", ["-win"])
*9:: SendModded("{F9}", ["-win"])
*0:: SendModded("{F10}", ["-win"])
*-:: SendModded("{F11}", ["-win"])
*=:: SendModded("{F12}", ["-win"])
; Media controls
#\:: Send("{Media_Play_Pause}")
#MButton:: Send("{Media_Play_Pause}")
#WheelDown:: Send("{Media_Prev}")
#[:: Send("{Media_Prev}")
#WheelUp:: Send("{Media_Next}")
#]:: Send("{Media_Next}")
; Autoclicker
#XButton2:: ToggleAutoclicker()
; Restart script
#^r:: {
    WindowsKey_Mode := false
    RestartScript()
}
#HotIf

#HotIf !is_laptop
; Swap + and = keys. If + is pressed, send = and vice versa
$*=:: {
    if GetKeyState("Shift", "P") {
        SendModded("{=}", ["-shift"])
    }
    else {
        SendModded("{+}", ["-shift"])
    }
}
#HotIf

#HotIf is_WindowsKey_Held and !is_laptop
; Nordic characters under Windows key mode (desktop only)
*sc01A:: SendCase("{Å}", "{å}")  ; {[}
*sc028:: SendCase("{Ä}", "{ä}")  ; {'}
*sc027:: SendCase("{Ö}", "{ö}")  ; {;}
#HotIf

#HotIf is_laptop
#HotIf