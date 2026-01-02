# AutoHotkey v2 Syntax Cheat Sheet

## Resources
- [**Official Documentation**](https://www.autohotkey.com/docs/v2/)
- [Key List (Gist)](https://gist.github.com/csharpforevermore/11348986)
- [Scan Codes (ISO105)](https://kbdlayout.info/kbdsw/scancodes+names?arrangement=ISO105)
- [Window Titles / WinTitle](https://www.autohotkey.com/docs/v2/misc/WinTitle.htm)

## Boilerplate
Standard setup for v2 scripts:
```autohotkey
#Requires AutoHotkey v2.0
#SingleInstance Force
#MaxThreadsPerHotkey 1
A_MenuMaskKey := "vkE8" ; VK for unassigned key, used to mask modifiers
```

## Symbols & Modifiers
| Symbol | Key | Description |
| :---: | --- | --- |
| `+` | **Shift** | |
| `^` | **Ctrl** | |
| `!` | **Alt** | |
| `#` | **Win** | |
| `<^>!` | **AltGr** | Left Ctrl + Right Alt |
| `&` | **Combine** | `Key1 & Key2::` (Combines two keys) |

## Hotkey Prefixes
| Prefix | Name | Description |
| :---: | --- | --- |
| `*` | **Wildcard** | Fires hotkey even if extra modifiers are held down. |
| `$` | **Hook** | Forces keyboard hook. Prevents `Send` from triggering the hotkey. |
| `~` | **Passthrough**| Do **not** block the key's native function when firing. |
| `UP` | **Release** | Fires upon release of the key (e.g., `a Up::`). |

## Mouse & Input
- **Buttons**: `LButton`, `RButton`, `MButton`, `XButton1` (Back), `XButton2` (Forward)
- **Wheel**: `WheelUp`, `WheelDown`, `WheelLeft`, `WheelRight`

```autohotkey
MouseGetPos &x, &y, &win_id, &control_id
MouseMove x, y
Click "Right"
```

## Context Directives
Control when hotkeys are active:
```autohotkey
#HotIf WinActive("ahk_exe chrome.exe")
    F1::MsgBox "Chrome is active"
#HotIf ; Turn off context (global)
```

## Key Concepts

### Blind Mode `{Blind}`
Gives the script more control by disabling automatic modifier handling.
- **Effect**: If `{Blind}` is the first item in the string, AHK will **not** release modifiers (Alt/Ctrl/Shift/Win) that you are physically holding down.
- **Usage**: Useful for remapping while preserving modifier states.
- **Example**: `+s::Send "{Blind}abc"` sends `ABC` (because Shift is held), whereas `+s::Send "abc"` would send `abc`.

---

## Examples

### Basic Remaps
```autohotkey
F2::Send "x"      ; Press F2 to type x
F3::Send "y"      ; Press F3 to type y
x::Send 1         ; Press x to type 1
```

### Modifiers & Hooks
```autohotkey
$y::Send 2        ; $ ensures Send 2 doesn't trigger other '2' hotkeys
~z::Send 3        ; Sends 'z' (native) then '3'
*LWin::Send "{LControl down}"     ; Wildcard allows firing even if other keys held
*LWin Up::Send "{LControl up}"    ; Handle key release
```

### Complex Logic
```autohotkey
; Custom Combination
F20 & z::MsgBox "Pressed F20 + Z"

; Toggle Logic
F1:: {
    static toggle := false
    toggle := !toggle
    if toggle
        MsgBox "On"
}
```
