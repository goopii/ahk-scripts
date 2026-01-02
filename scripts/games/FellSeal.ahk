#SingleInstance force
#IfWinActive ahk_exe Fell Seal.exe
{
;backward
+XButton1::
    Send, {left}
    Send, {q}
Return

;forward
+XButton2::
    Send, {right}
    Send, {e}
Return

;backward
~XButton1::
Return

;forward
~XButton2::
Return


~WheelDown::
    Send, {d}
    Send, {n}
Return
~WheelUp::
    Send, {a}
    Send, {h}
Return
}
