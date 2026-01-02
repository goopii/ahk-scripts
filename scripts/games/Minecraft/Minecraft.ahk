#CommentFlag //


F4::
	Suspend
return

//spectator mode
//f::
//	Send, {F3 down}{n}{F3 up}
//return

//craft
#IfWinActive, Minecraft
$t::
	Send, {Enter}
	sleep 50
	Send, /craft
	sleep 50
	Send, {Enter}
return 