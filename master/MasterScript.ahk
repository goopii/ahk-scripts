#MaxThreadsPerHotkey 1
#SingleInstance Force
#Requires AutoHotkey v2.0
A_MenuMaskKey := "vkE8"
; Relaunch elevated if not running as Administrator
if !A_IsAdmin {
    Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
    ExitApp
}

;==============================================================================
; INCLUDES
;==============================================================================
#include ../gui/gui_log.ahk
#include ../gui/gui_toast.ahk
#include ../utils/WindowsNotification.ahk
#include ../utils/IsLaptop.ahk
#include ../utils/IsFullscreen.ahk
#include ../utils/GetActiveMonitor.ahk
#include ../utils/MouseOverTaskbar.ahk
#include ../utils/SendCase.ahk
#include ../utils/SendModded.ahk
#include ../utils/ToggleAutoclicker.ahk
#include ../utils/GetDefaultEditor.ahk
;==============================================================================
; GLOBALS
;==============================================================================
global WinKey := false
global EditorPath := GetDefaultEditorPath()
global EditorExe := GetDefaultEditorExe()
;==============================================================================
; INITIALIZATION
;==============================================================================
LogState(false)
WindowsNotification("MasterScript", "Script loaded")

*$LWin:: {
    global WinKey
    WinKey := true
    Send("{LWin DownTemp}")
    ; Wait for key release
    KeyWait("LWin")
    WinKey := false
    Send("{LWin up}")
}

SetCapsLockState("AlwaysOff")

; CapsLock hyperkey - sends Ctrl+Alt+Shift+Win when held
$*CapsLock:: {
    Send("{Ctrl Down}{Alt Down}{Shift Down}{LWin Down}")
    KeyWait("CapsLock")
    Send("{Ctrl Up}{Alt Up}{Shift Up}{LWin Up}")
}
;==============================================================================
; MODULES
;==============================================================================
#include ./Apps.ahk
#include ./Debug.ahk
#include ./Games.ahk
#include ./Global.ahk
#include ./WinKeyLayer.ahk
