#Requires AutoHotkey v2.0

#include ./utils/SendModded.ahk
#include ./utils/IsLaptop.ahk
#include ./utils/SendCase.ahk

global WinKey := false

*$LWin:: {
  global WinKey
  WinKey := true
  Send("{LWin DownTemp}")
  ; Wait for key release
  KeyWait("LWin")
  WinKey := false
  ; if A_TimeSinceThisHotkey < 1000 {
  ;   Log("Fast press detected, ignoring")
  ; }
  ; else {
  ;   Log("Slow press detected, releasing")
  ;   Send("{LWin up}")
  ; }
  keyStateP := GetKeyState("LWin", "P")
  keyStateT := GetKeyState("LWin", "T")
  Log("keyStateP: " keyStateP, ThisHotkey)
  Log("keyStateT: " keyStateT, ThisHotkey)
  Log("------------------------------------", ThisHotkey)
  Send("{LWin up}")
}
; k:: {
;   Log("k pressed")
; }

#HotIf WinKey
; backtick{`} and tilde{~}
*Esc:: {
  if GetKeyState("Shift", "P") { ; {`}
    SendModded("{U+0060}", ["alt", "ctrl"])
  }
  else { ; {~}
    SendModded("{~}", ["alt", "ctrl"])
  }
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
#]:: Send("{Media_Next}")
#[:: Send("{Media_Prev}")

#MButton:: Send("{Media_Play_Pause}")
; #WheelDown:: Send("{Media_Next}")
; #WheelUp:: Send("{Media_Prev}")
#WheelDown:: Send("{Volume_Down}")
#WheelUp:: Send("{Volume_Up}")


#HotIf

#HotIf WinKey and !is_laptop
; Nordic characters under Windows key mode (desktop only)
*;:: SendCase("{Å}", "{å}")
*':: SendCase("{Ä}", "{ä}")
*/:: SendCase("{Ö}", "{ö}")
#HotIf