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
