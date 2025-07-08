#Requires AutoHotkey v2.0

; ZEN
#HotIf WinActive("ahk_exe zen.exe")
$!w:: {
    SendModded("{PgUp}", ["+ctrl", "-alt"])
}
$!s:: {
    SendModded("{PgDn}", ["+ctrl", "-alt"])
}
; Toggle Compact Mode
$^Tab:: {
    Send("{F24}")
}
#HotIf
; SPOTIFY
#HotIf WinActive("ahk_exe Spotify.exe")
^d:: {
    prev_clipboard := A_Clipboard
    A_Clipboard := "" ; Clear clipboard
    Send("^c")
    if ClipWait(1, true) { ; Wait 1 second for text to be copied
        A_Clipboard := "/*" A_Clipboard "*/"
        Send("^v")
        Sleep(50) ; Ensure paste completes
    }
    A_Clipboard := prev_clipboard ; Restore clipboard
    return
}
#HotIf