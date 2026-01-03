#MaxThreadsPerHotkey 1
#SingleInstance Force
#Requires AutoHotkey v2.0
A_MenuMaskKey := "vkE8"
; Relaunch elevated if not running as Administrator
if !A_IsAdmin {
    Run('*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"')
    ExitApp()
}

;==============================================================================
; INCLUDES
;==============================================================================
#include ./debug/Logger.ahk
#include ./utils/WindowsNotification.ahk
#include ./utils/GetDefaultEditor.ahk
;==============================================================================
; GLOBALS
;==============================================================================
global EditorPath := GetDefaultEditorPath()
global EditorExe := GetDefaultEditorExe()
;==============================================================================
; INITIALIZATION
;==============================================================================
WindowsNotification(A_ScriptName, "Script loaded")
LogState(false)


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
#include ./debug/Debug.ahk
#include ./Games.ahk
#include ./Global.ahk
#include ./WinKeyLayer.ahk
