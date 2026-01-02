#Requires AutoHotkey v2.0
<<<<<<< HEAD:utils/SendModded.ahk
#include ./GetIndexOfValue.ahk
#include ../gui/gui_log.ahk
=======
#include <GetIndexOfValue>
#include <gui_log>
>>>>>>> 909006942b8bbe7c3e28912b8b0ec2bb3d389fc3:Lib/SendModded.ahk
; Function to send a key with modifiers with optional forced or ignored modifiers
; key (required)     - The key to send
; options (optional) - Array of options allowing for modifiers to be forced or ignored
; Example:
;   "-shift" (ignore)
;   "+shift" (force)
SendModded(key, options := []) {
    modifiers := ["alt", "shift", "ctrl", "win"]

    ; Handle forced or ignored modifiers
    for mod in options {
        prefix := SubStr(mod, 1, 1)
        optionMod := SubStr(mod, 2)
        index := GetIndexOfValue(modifiers, optionMod)
        if prefix == "-" {
            if index {
                modifiers.RemoveAt(index)
                ; Send("{Blind}{" optionMod " up}")
            }
        }
        else if prefix == "+" {
            ; InsertAt pushes the next element to the right
            ; So we need to remove the element after the index
            modifiers.InsertAt(index, mod)
            modifiers.RemoveAt(index + 1)
        }
    }
    ; Create the modifier string
    modString := ""
    for mod in modifiers {
        prefix := SubStr(mod, 1, 1)
        ; Log("Modifier: " mod)
        if prefix == "+" or prefix == "-" {
            mod := SubStr(mod, 2)
            ; Log("Modifier: " mod)
        }
        switch mod {
            case "alt":
                if prefix == "+" or GetKeyState("Alt", "P") {
                    modString .= "!"
                }
            case "shift":
                if prefix == "+" or GetKeyState("Shift", "P") {
                    modString .= "+"
                }
            case "ctrl":
                if prefix == "+" or GetKeyState("Control", "P") {
                    modString .= "^"
                }
            case "win":
                if prefix == "+" or (GetKeyState("LWin", "P") or GetKeyState("RWin", "P")) {
                    modString .= "#"
                }
            default:
                throw "Invalid modifier: " mod
        }
    }
    Log("SendModded Send: " modString key)
    Send(modString key)
}
