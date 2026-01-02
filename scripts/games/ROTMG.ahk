#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

dash_on := False
input_vector := [0, 0]

#IfWinActive ahk_exe RotMG Exalt.exe
;if WinActive("ahk_id 0x5014e")
*f::
    Send, {9}
    Sleep, 650
    Send, {0}
return



~w::
    input_vector[0] := 1
return
~w Up::
    input_vector[0] := 0
return

~s::
    input_vector[0] := -1
return
~s Up::
    input_vector[0] := 0
return

~d::
    input_vector[1] := 1
return
~d Up::
    input_vector[1] := 0
return

~a::
    input_vector[1] := -1
return
~a Up::
    input_vector[1] := 0
return




F1::
    dash_on := True
    ToolTip, %dash_on%, 10, 10
return


#if WinActive("ahk_exe RotMG Exalt.exe") and dash_on
    RButton::
            MouseGetPos, mouseX, mouseY
            x := (A_ScreenWidth - 470) /2
            y := (A_ScreenHeight + 650) /2
       
            if (input_vector == [0,0])
            {
                x := mouseX
                y := mouseY 
            }
            else {
                x += 500 * input_vector[1]
                y -= 500 * input_vector[0]
            }
            MouseMove, x, y
            Send, {RButton}
            MouseMove, mouseX, mouseY

        return