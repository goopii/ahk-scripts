#Requires AutoHotkey v2.0

; Check if mouse is over taskbar
mouseOverTaskbar() {
    CoordMode("Mouse", "Screen")  ; Set coordinate mode to screen

    mousePos := MouseGetPos(&mouseX, &mouseY, &mouseWin, &mouseControl)

    ; Check for main taskbar
    if WinExist("ahk_class Shell_TrayWnd") {
        WinGetPos(&taskX, &taskY, &taskW, &taskH, "ahk_class Shell_TrayWnd")
        if (mouseX >= taskX && mouseX < taskX + taskW
            && mouseY >= taskY && mouseY < taskY + taskH) {
            return true
        }
    }
    return false
} 