#Requires AutoHotkey v2.0

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