
SendMode Input
#SingleInstance force






`::
    CoordMode, Pixel

    MouseGetPos, mouseX, mouseY
    click
    Sleep 1
    MouseMove, (mouseX + (100)), (mouseY + (275))
    Sleep 1
    click
Return