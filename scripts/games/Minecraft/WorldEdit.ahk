#IfWinActive ahk_exe javaw.exe
{
	suspended := False
	ToolTip, %suspended%, 10, 10

	$Enter::
		suspended := !suspended
		ToolTip, %suspended%, 10, 10
		Send, {Enter}
	return

	$Tab::
		suspended := !suspended
		ToolTip, %suspended%, 10, 10
		Send, {Tab}
	return

	$Esc::
		suspended := !suspended
		ToolTip, %suspended%, 10, 10
		Send, {Esc}
	return

	$/::
	if(!suspended) {
		suspended := True
	}
		ToolTip, %suspended%, 10, 10
		Send, {/}
	return

	$^Space::
		BlockInput, On
		Send, {_}
		BlockInput, Off
	return 

	$b::
		Send, {F3 down}
		Send, {n down}
		Send, {F3 up}
		Send, {n up}
	return










	;pos1
	;#if !suspended
	$q::
	if(!suspended) {
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /pos1
		sleep 50
		Send, {Enter}

		BlockInput, Off
		}
		else{
		Send, q
		}
	return 

	;pos2
	;#if !suspended
	$e::
	if(!suspended) {
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /pos2
		sleep 50
		Send, {Enter}

		BlockInput, Off
		}
		else{
		Send, e
		}
	return 

	;set
	;#if !suspended
	$f::
	if(!suspended) {
		suspended := True
		ToolTip, %suspended%, 10, 10
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /set{space}
		BlockInput, Off
		}
		else{
		Send, f
		}
	return 

	;move
	;#if !suspended
	$g::
	if(!suspended) {
		suspended := True
		ToolTip, %suspended%, 10, 10
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /move{space}
		BlockInput, Off
		}
		else{
		Send, g
		}
	return 

	;Last command
	;#if !suspended
	$t::
	if(!suspended) {
		BlockInput, On

		Send, {Enter}
		sleep 50
		Send, {Up}
		sleep 50
		Send, {Enter}

		BlockInput, Off
		}
		else{
		Send, t
		}
	return 

	;flip and rotate
	;#if !suspended
	$y::
	if(!suspended) {
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /flip
		sleep 50
		Send, {Enter}

		Send, {/}
		sleep 50
		Send, /rotate 180
		sleep 50
		Send, {Enter}

		BlockInput, Off
		}
		else{
		Send, y
		}
	return 

	;undo
	;#if !suspended
	$z::
	if(!suspended) {
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /undo
		sleep 50
		Send, {Enter}

		BlockInput, Off
		}
		else{
		Send, z
		}
	return 

	;redo
	;#if !suspended
	$x::
	if(!suspended) {
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /redo
		sleep 50
		Send, {Enter}

		BlockInput, Off
		}
		else{
		Send, x
		}
	return 

	;cut
	;#if !suspended
	$r::
	if(!suspended) {
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /cut
		sleep 50
		Send, {Enter}

		BlockInput, Off
		}
		else{
		Send, r
		}
	return 

	;copy
	;#if !suspended
	$c::
	if(!suspended) {
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /copy
		sleep 50
		Send, {Enter}

		BlockInput, Off
	}
	else{
	Send, c
	}
	return 

	;paste
	;#if !suspended
	$v::
	if(!suspended) {
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /paste
		sleep 50
		Send, {Enter}

		BlockInput, Off
	}
	else{
	Send, v
	}
	return 

	;deselect
	;#if !suspended
	$`::
	if(!suspended) {
		BlockInput, On

		Send, {/}
		sleep 50
		Send, /deselect
		sleep 50
		Send, {Enter}

		BlockInput, Off
	}
	else{
	Send, {`}
	}
	return 
}

