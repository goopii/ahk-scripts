; FancyWM Script for AutoHotkey (https://www.autohotkey.com)
; Install AutoHotkey v2
; Run winget install -e --id AutoHotkey.AutoHotkey
; Then open this script with AutoHotkey to enable it.
;
; Lines starting with a semicolon (;) are comments and are disabled.
; Use this script to extend FancyWM using AutoHotkey.
; Below is a quick example to get you started.
; And further down you will find a list of the commands available to you.

#Requires AutoHotkey v2.0.2
#SingleInstance Force
FancyWM(action) {
    RunWait(format("fancywm.exe --action {}", action), , "Hide")
}

; AutoHotkey hotkey syntax:
; # = Win key          -> ^#R = Ctrl+Win+R
; ^ = Ctrl key         -> ^r = Ctrl+R
; ! = Alt key          -> !r = Alt+R
; + = Shift key        -> +r = Shift+R

; Ctrl+Shift+Win+Right: Move window to the right desktop and switch to that desktop
^+#Right::{
    FancyWM("MoveToRightDesktop")
    FancyWM("SwitchToRightDesktop")
}

; Ctrl+Shift+Win+Left: Move window to the left desktop and switch to that desktop
^+#Left::{
    FancyWM("MoveToLeftDesktop")
    FancyWM("SwitchToLeftDesktop")
}

; Below is a list of the commands available to you.
; FancyWM("ToggleManager")            ; Toggle FancyWM's window management functionality
; FancyWM("RefreshWorkspace")         ; Force a change-detection cycle of the whole workspace
; FancyWM("Cancel")                   ; Cancel the action
; FancyWM("MoveFocusLeft")            ; Focus the window to the left of the current window
; FancyWM("MoveFocusUp")              ; Focus the window above the current window
; FancyWM("MoveFocusRight")           ; Focus the window to the right of the current window
; FancyWM("MoveFocusDown")            ; Focus the window below the current window
; FancyWM("ShowDesktop")              ; Show/hide the desktop
; FancyWM("CreateHorizontalPanel")    ; Create a new horizontal panel around the focused window
; FancyWM("CreateVerticalPanel")      ; Create a new vertical panel around the focused window
; FancyWM("CreateStackPanel")         ; Create a new stack panel around the focused window
; FancyWM("PullWindowUp")             ; Move the window out of its containing panel
; FancyWM("ToggleFloatingMode")       ; Toggle floating mode for the focused window
; FancyWM("MoveLeft")                 ; Move the window next to the window on the left
; FancyWM("MoveUp")                   ; Move the window next to the window above
; FancyWM("MoveRight")                ; Move the window next to the window on the right
; FancyWM("MoveDown")                 ; Move the window next to the window below
; FancyWM("SwapLeft")                 ; Swap the current window with the window on its left
; FancyWM("SwapUp")                   ; Swap the current window with the window above it
; FancyWM("SwapRight")                ; Swap the current window with the window on its right
; FancyWM("SwapDown")                 ; Swap the current window with the window below it
; FancyWM("IncreaseWidth")            ; Increase the width of the focused window
; FancyWM("IncreaseHeight")           ; Increase the height of the focused window
; FancyWM("DecreaseWidth")            ; Decrease the width of the focused window
; FancyWM("DecreaseHeight")           ; Decrease the height of the focused window
; FancyWM("SwitchToPreviousDesktop")  ; Switch from the current virtual desktop to the previous virtual desktop
; FancyWM("SwitchToLeftDesktop")      ; Switch from the current virtual desktop to the virtual desktop on the left
; FancyWM("SwitchToRightDesktop")     ; Switch from the current virtual desktop to the virtual desktop on the right
; FancyWM("SwitchToDesktop1")         ; Switch from the current virtual desktop to virtual desktop 1
; FancyWM("SwitchToDesktop2")         ; Switch from the current virtual desktop to virtual desktop 2
; FancyWM("SwitchToDesktop3")         ; Switch from the current virtual desktop to virtual desktop 3
; FancyWM("SwitchToDesktop4")         ; Switch from the current virtual desktop to virtual desktop 4
; FancyWM("SwitchToDesktop5")         ; Switch from the current virtual desktop to virtual desktop 5
; FancyWM("SwitchToDesktop6")         ; Switch from the current virtual desktop to virtual desktop 6
; FancyWM("SwitchToDesktop7")         ; Switch from the current virtual desktop to virtual desktop 7
; FancyWM("SwitchToDesktop8")         ; Switch from the current virtual desktop to virtual desktop 8
; FancyWM("SwitchToDesktop9")         ; Switch from the current virtual desktop to virtual desktop 9
; FancyWM("MoveToPreviousDesktop")    ; Move the focused window from the current virtual desktop to the previous virtual desktop
; FancyWM("MoveToLeftDesktop")        ; Move the focused window from the current virtual desktop to virtual desktop on the left
; FancyWM("MoveToRightDesktop")       ; Move the focused window from the current virtual desktop to virtual desktop on the right
; FancyWM("MoveToDesktop1")           ; Move the focused window from the current virtual desktop to virtual desktop 1
; FancyWM("MoveToDesktop2")           ; Move the focused window from the current virtual desktop to virtual desktop 2
; FancyWM("MoveToDesktop3")           ; Move the focused window from the current virtual desktop to virtual desktop 3
; FancyWM("MoveToDesktop4")           ; Move the focused window from the current virtual desktop to virtual desktop 4
; FancyWM("MoveToDesktop5")           ; Move the focused window from the current virtual desktop to virtual desktop 5
; FancyWM("MoveToDesktop6")           ; Move the focused window from the current virtual desktop to virtual desktop 6
; FancyWM("MoveToDesktop7")           ; Move the focused window from the current virtual desktop to virtual desktop 7
; FancyWM("MoveToDesktop8")           ; Move the focused window from the current virtual desktop to virtual desktop 8
; FancyWM("MoveToDesktop9")           ; Move the focused window from the current virtual desktop to virtual desktop 9
; FancyWM("SwitchToPreviousDisplay")  ; Switch from the current display to the previous display
; FancyWM("SwitchToDisplay1")         ; Switch from the current display to display 1
; FancyWM("SwitchToDisplay2")         ; Switch from the current display to display 2
; FancyWM("SwitchToDisplay3")         ; Switch from the current display to display 3
; FancyWM("SwitchToDisplay4")         ; Switch from the current display to display 4
; FancyWM("SwitchToDisplay5")         ; Switch from the current display to display 5
; FancyWM("SwitchToDisplay6")         ; Switch from the current display to display 6
; FancyWM("SwitchToDisplay7")         ; Switch from the current display to display 7
; FancyWM("SwitchToDisplay8")         ; Switch from the current display to display 8
; FancyWM("SwitchToDisplay9")         ; Switch from the current display to display 9
; FancyWM("MoveToPreviousDisplay")    ; Move the focused window from the current display to the previous display
; FancyWM("MoveToDisplay1")           ; Move the focused window from the current display to display 1
; FancyWM("MoveToDisplay2")           ; Move the focused window from the current display to display 2
; FancyWM("MoveToDisplay3")           ; Move the focused window from the current display to display 3
; FancyWM("MoveToDisplay4")           ; Move the focused window from the current display to display 4
; FancyWM("MoveToDisplay5")           ; Move the focused window from the current display to display 5
; FancyWM("MoveToDisplay6")           ; Move the focused window from the current display to display 6
; FancyWM("MoveToDisplay7")           ; Move the focused window from the current display to display 7
; FancyWM("MoveToDisplay8")           ; Move the focused window from the current display to display 8
; FancyWM("MoveToDisplay9")           ; Move the focused window from the current display to display 9