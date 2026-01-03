#Requires AutoHotkey v2.0
#include ./utils/IsFullscreen.ahk
#include ./utils/SendModded.ahk
#include ./utils/IsLaptop.ahk
#include ./utils/MouseOverTaskbar.ahk

+!a:: {
  Send("{Browser_Back}")
}
+!d:: {
  Send("{Browser_Forward}")
}

; Middle-click on taskbar to close window
#HotIf MouseOverTaskbar()
MButton Up:: {
  Click("Right")
  Sleep(GetDeviceValue(250, 250))
  Send("{Up}{Enter}")
}
#HotIf

#HotIf !IsFullscreen()
^MButton:: {  ; [Ctrl] + middle click
    Send("{Delete}")
}
+MButton:: {  ; [Shift] + middle click
  ; if not IsFullscreen() {
    Send("{Enter}")
  ; }
}
#HotIf

; [alt] + F4
^!w:: {
  SendModded("{F4}", ["+alt", "-ctrl"])
}

; Send [win]+[ctrl] + F12 for Groupy2 hotkey
!Tab:: {
  SendModded("{F13}", ["-alt", "+win"])
}
; Send [win] + F12 for Groupy2 hotkey
#Tab:: {
  SendModded("{F13}", ["+ctrl", "+win"])
}

#HotIf !is_laptop
; Swap + and = keys. If + is pressed, send = and vice versa
$*=:: {
  if GetKeyState("Shift", "P") {
    SendModded("{=}", ["-shift"])
  }
  else {
    SendModded("{+}", ["-shift"])
  }
}
#HotIf