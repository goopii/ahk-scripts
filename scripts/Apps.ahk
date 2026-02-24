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

; Chrome / Chromium
#HotIf WinActive("ahk_exe chrome.exe")
^!z:: {
    SendModded("^t", ["+shift", "-ctrl", "-alt"])
}
; Next Tab
!a:: {
    SendModded("{PgUp}", ["-alt", "+ctrl"])
}
; Previous Tab
!d:: {
    SendModded("{PgDn}", ["-alt", "+ctrl"])
}
; Search in current tab
!e:: {
    SendModded("{Home}", ["+alt"])
}
; Search in new tab
^e:: {
    SendModded("{t}", ["+ctrl"])
}
; Split view
!s:: {
    SendModded("{n}", ["+shift", "+alt"])
}
#HotIf

