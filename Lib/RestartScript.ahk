#Requires AutoHotkey v2.0

; Restarts script for debugging
RestartScript() {
    try {
        if A_IsCompiled
            Run(A_ScriptFullPath)
        else
            Run(Format('"{1}" "{2}"', A_AhkPath, A_ScriptFullPath))
        ExitApp
    } catch Error as e {
        MsgBox("Failed to restart script: " e.Message, "Restart Error", "Icon!")
        return false
    }
    return true
}
