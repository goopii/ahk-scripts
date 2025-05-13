#Requires AutoHotkey v2.0

#include ./HasValue.ahk
; Send a key with modifiers
; key - The key to send
; modifiers - Array of modifier keys to include.
; "alt", "shift", "ctrl", "win", "all"
;Example:   
;   "shift" (if pressed)
;   "-shift" (ignore)
;   "+shift" (force)
;   "all" (all modifiers if pressed)
;   "+all" (force all modifiers)
;If no modifiers provided, defaults to ["alt", "shift", "ctrl", "win"]
SendModded(key, modifiers := []) {
    allModifiers := ["alt", "shift", "ctrl", "win"]
    ; Build modifier string
    modString := ""
    if modifiers.Length = 0 {
        modifiers := allModifiers
    }
    ; Handle "all" and "+all" special cases
    else if HasValue(modifiers, "all") or HasValue(modifiers, "+all") {
        ; Remove any negated modifiers from allModifiers
        for mod in modifiers {
            if SubStr(mod, 1, 1) = "-" {
                negatedMod := SubStr(mod, 2)
                if HasValue(allModifiers, negatedMod)
                    allModifiers.RemoveAt(HasValue(allModifiers, negatedMod))
            }
        }
        ; Replace "all" or "+all" with the filtered allModifiers
        modifiers := allModifiers
        if HasValue(modifiers, "+all")
            for i, mod in modifiers
                modifiers[i] := "+" mod
    }

    for mod in modifiers {
        ; Handle modifiers with prefixes
        prefix := SubStr(mod, 1, 1)
        if prefix = "-"  ; Skip if modifier starts with minus
            continue
        if prefix = "+"  ; Remove plus prefix if present
            mod := SubStr(mod, 2)
            
        switch mod {
            case "alt":
                if prefix = "+" or GetKeyState("Alt", "P") {
                    modString .= "!"
                }
            case "shift":
                if prefix = "+" or GetKeyState("Shift", "P") {
                    modString .= "+"
                }
            case "ctrl":
                if prefix = "+" or GetKeyState("Control", "P") {
                    modString .= "^"
                }
            case "win":
                if prefix = "+" or (GetKeyState("LWin", "P") or GetKeyState("RWin", "P")) {
                    modString .= "#"
                }
            default:
                throw "Invalid modifier: " mod
        }
    }
    Send(modString key)
}