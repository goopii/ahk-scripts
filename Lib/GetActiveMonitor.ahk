#Requires AutoHotkey v2.0

; Get active monitor dimensions
GetActiveMonitor() {
    WinGetPos(&winX, &winY, &winW, &winH, "A")
    winCenterX := winX + (winW / 2)
    winCenterY := winY + (winH / 2)

    loop MonitorGetCount() {
        MonitorGet(A_Index, &L, &T, &R, &B)
        if (winCenterX >= L && winCenterX <= R && winCenterY >= T && winCenterY <= B)
            return { x: L, y: T, w: R - L, h: B - T }
    }
    return false
} 