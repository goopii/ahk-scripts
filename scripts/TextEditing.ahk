
; Select current line
^Space:: {
    Send("{Home}")
    SendModded('{End}', ['+shift', '-ctrl'])
}
; Delete current line
+Backspace:: {
    Send("{Home}")
    SendModded('{End}', ['+shift', '-ctrl'])
    Send("{Backspace}")
}
; Delete selected lines
+^Backspace:: {
    SendModded('{Home}', ['+shift', '-ctrl'])
    Send("{Backspace}")
}
; Select and cut word
+^x:: {
    SendModded('{Right}', ['+shift', '+ctrl'])
    SendModded('{x}', ['-shift', '+ctrl'])
}
