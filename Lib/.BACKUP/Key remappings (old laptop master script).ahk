#NoTrayIcon
#SingleInstance

F12::PrintScreen

End::Media_Play_Pause
+!Up::Media_Play_Pause

Insert::Media_Next
!PgDn::Media_Next

Home::Media_Prev
!PgUp::Media_Prev

PgUp::return

PgDn::return

^PgUp::XButton1

^PgDn::XButton2

*+MButton:: ; Shift + Middle Mouse Button
   send, {Enter}
return

*^MButton:: ; Ctrl + Middle Mouse Button
   send, {Delete}
return

*#MButton:: ; Windows + Middle Mouse Button
   send, {Media_Play_Pause}
return
