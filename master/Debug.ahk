#Requires AutoHotkey v2.0
#Include ../utils/RestartScript.ahk

#HotIf WinActive("ahk_exe " EditorExe)
; #HotIf WinActive("ahk_exe Cursor.exe")
~^s:: {
  ; Get the title of the active window
  activeTitle := WinGetTitle("A")
  ; Check if the active file matches the script name
  if (InStr(activeTitle, A_ScriptName) || InStr(activeTitle, "ahk-scripts")) {
    Sleep(100)  ; Small delay to ensure save completes
    ; RestartScript()
    Reload()
  }
}
#HotIf
; Open ahk-scripts folder in Current Editor
#!o:: {
  global EditorPath
  ; Run(
  ;   EditorPath, "C:\Users\malte\OneDrive\ahk-scripts"
  ; )
  ; Run(EditorPath)
  ; Run("C:\Users\malte\AppData\Local\Programs\cursor\Cursor.exe")
  Run("C:\Users\malte\AppData\Local\Programs\cursor\Cursor.exe", "C:\Users\malte\OneDrive\ahk-scripts")
}

; Show log window
#!l:: {
  LogState("toggle")
  LogDisplay("toggle")
}

; HKCU\Software\Classes\AutoHotkeyScript\shell\edit\command