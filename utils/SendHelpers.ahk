#Requires AutoHotkey v2.0

; Send a key with modifiers
SendModded(key, modifiers := []) {
    ; Build modifier string
    modString := ""
    for mod in modifiers {
        switch mod {
            case "alt":
                if GetKeyState("Alt", "P") {
                    modString .= "!"
                }
            case "shift":
                if GetKeyState("Shift", "P") {
                    modString .= "+"
                }
            case "ctrl":
                if GetKeyState("Control", "P") {
                    modString .= "^"
                }
            case "win":
                if (GetKeyState("LWin", "P") or GetKeyState("RWin", "P")) {
                    modString .= "#"
                }
        }
    }
    Send(modString key)
}

; Send a character with case sensitivity
SendCase(upperChar, lowerChar) {
    isUpper := GetKeyState("Capslock", "T") != GetKeyState("Shift")
    Send(isUpper ? upperChar : lowerChar)
} 