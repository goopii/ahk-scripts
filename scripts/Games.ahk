#Requires AutoHotkey v2.0

; Path of Achra
#HotIf WinActive("ahk_exe PathofAchra.exe")
; Inventory
Tab:: {
  Send("{i}")
}
; Inventory
XButton1:: { ; Forward
  Send("{i}")
}
; Powers
XButton2:: { ; Backward
  Send("{p}")
}
; Log
MButton:: {
  Send("{g}")
}
WheelDown:: {
  Send("{Space}")

}
WheelUp:: {
  Send("{Tab}")
}
#HotIf

; PATH OF EXILE
#HotIf WinActive("ahk_exe PathOfExileSteam.exe") || WinActive("ahk_exe PathOfExile_x64Steam.exe")
5:: {
  Send("{Enter}")
  Send("/hideout")
  Send("{Enter}")
}
#HotIf