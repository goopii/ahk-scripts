#IfWinActive, Path of Exile
#MaxThreadsPerHotkey 2
toggle := false

F4::
    toggle := !toggle 
    ToolTip, %toggle%, 10, 10
return

*d::
    If (toggle)
            Send, dfr
    Else
        Send, d
return