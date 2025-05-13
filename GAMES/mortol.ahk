#Requires AutoHotkey v2.0
#SingleInstance

#HotIf WinActive("ahk_exe ufo50.exe")

1::{
    Send "{w down}"
    Send "{Left}"
}

1 up::{
    Send "{w up}"
}

2::{
    Send "{s down}"
    Send "{Left}"
}


2 up::{
    Send "{s up}"
}