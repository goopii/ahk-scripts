#Requires AutoHotkey v2.0

; Middle-click on taskbar to close window
#HotIf mouseOverTaskbar()
MButton Up:: {
  Click("Right")
  Sleep(GetDeviceValue(250, 250))
  Send("{Up}{Enter}")
}
#HotIf

^MButton:: {  ; [Ctrl] + middle click
  if not IsFullscreen() {
    Send("{Delete}")
  }
}
+MButton:: {  ; [Shift] + middle click
  if not IsFullscreen() {
    Send("{Enter}")
  }
}

+!a:: {
  Send("{Browser_Back}")
}
+!d:: {
  Send("{Browser_Forward}")
}

; [alt] + F4
^!w:: {
  SendModded("{F4}", ["+alt", "-ctrl"])
}

; Send [win]+[ctrl] + F12 for Groupy2 hotkey
!Tab:: {
  SendModded("{F12}", ["-alt", "+win"])
}
; Send [win] + F12 for Groupy2 hotkey
#Tab:: {
  SendModded("{F12}", ["+ctrl", "+win"])
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