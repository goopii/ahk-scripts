#Include ./RestartScript.ahk

#HotIf WinActive("ahk_exe Cursor.exe")
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