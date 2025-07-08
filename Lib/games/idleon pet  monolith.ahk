#MaxThreadsPerHotkey 3
#SingleInstance, force
#IfWinActive ahk_exe LegendsOfIdleon.exe
{

;  2        3        4       5      6
;bones, monolith, coffee, coffee, burger

;monolith
F2::
	Toggle := !Toggle
	ToolTip, monolith on, 10, 10, 1
	Loop
	{
		If (!Toggle){
			;SetTimer, RemoveToolTip, -10
			ToolTip, monolith off, 10, 10, 1
			Break
		}
		;monolith
		Send, 3
		;duration of monolith
		Sleep 6000
		;wait a bit before using coffee
		Sleep 250
		
		;coffee
		Send, 54
		;wait for the attacks to land to recharge monolith
		Sleep 2000
	}
return

}