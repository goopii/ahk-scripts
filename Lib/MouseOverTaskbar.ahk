#Requires AutoHotkey v2.0

mouseOverTaskbar() {
    CoordMode("Mouse", "Screen")

    mousePos := MouseGetPos(&mouseX, &mouseY, &mouseWin, &mouseControl)

    if WinExist("ahk_class Shell_TrayWnd") {
        WinGetPos(&taskX, &taskY, &taskW, &taskH, "ahk_class Shell_TrayWnd")
        if (mouseX >= taskX && mouseX < taskX + taskW
            && mouseY >= taskY && mouseY < taskY + taskH) {
            return true
        }
    }
    return false
}
