#Requires AutoHotkey v2.0

#include ./utils/SendModded.ahk
#include ./utils/IsLaptop.ahk
#include ./utils/SendCase.ahk
#include ./utils/TwinkleTrayOffset.ahk

global WinKey := false



*$LWin:: {
  global WinKey
  WinKey := true
  Send("{LWin DownTemp}")
  ; Wait for key release
  KeyWait("LWin")
  WinKey := false
  Send("{LWin up}")
}

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
#WheelDown:: Send("{Volume_Down}")
#WheelUp:: Send("{Volume_Up}")

#^!WheelDown:: TwinkleTrayOffset(-1)
#^!WheelUp:: TwinkleTrayOffset(1)

#^WheelDown:: Send("{Media_Next}")
#^WheelUp:: Send("{Media_Prev}")

; Win+L: Windows grabs this before AHK. Disable via registry first:
;   HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
;   DWORD DisableLockWorkstation = 1
#l:: {
  return
}

#HotIf

#HotIf WinKey and !is_laptop
; Nordic characters under Windows key mode (desktop only)
*;:: SendCase("{Å}", "{å}")
*':: SendCase("{Ä}", "{ä}")
*/:: SendCase("{Ö}", "{ö}")
#HotIf