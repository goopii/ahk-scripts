#MaxThreadsPerHotkey 3
#SingleInstance, force
#IfWinActive ahk_exe LegendsOfIdleon.exe
{

;  2        3        4       5      6
;bones, monolith, coffee, coffee, burger

;spam
F3::
	Toggle := !Toggle
	ToolTip, spam on, 175, 10, 2
	Loop
	{
		If (!Toggle){
			;SetTimer, RemoveToolTip, -10
			ToolTip, spam off, 10, 10, 2
			Break
		}
		;Burger, bones
		Send, 26
		Sleep 40
	}
return

}