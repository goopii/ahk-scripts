#Requires AutoHotkey v2.0

; Send a character with case sensitivity
SendCase(upperChar, lowerChar) {
    isUpper := GetKeyState("Capslock", "T") != GetKeyState("Shift")
    Send(isUpper ? upperChar : lowerChar)
} 