#Requires AutoHotkey v2.0

; Check if active window is fullscreen
IsFullscreen() {
    WinGetPos &X, &Y, &W, &H, "A"
    return (X == 0 and Y == 0 and W == A_ScreenWidth and H == A_ScreenHeight)
} 