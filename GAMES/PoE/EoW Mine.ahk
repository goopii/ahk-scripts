#IfWinActive, Path of Exile
#MaxThreadsPerHotkey 2
toggle := false

F4::
    toggle := !toggle 
    ToolTip, %toggle%, 10, 10
return

*RButton::
    If (toggle)
        While GetKeyState("RButton", "P"){
            Click, Right
            Send, {o}
            Sleep, 100
        }
    Else
        While GetKeyState("RButton", "P"){
            Click, Right
            Sleep, 100
        }
return