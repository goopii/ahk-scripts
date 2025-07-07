#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  	; Ensures a consistent starting directory.
#SingleInstance force			; Only one script allowed open


vidDistX := 375
vidDistY := 245



`::
	img := "C:\Users\malte\Desktop\AHK scripts\NotInt.png"
	CoordMode, Pixel
	;ToolTip, ., mouseX-25, mouseY-400, 1
	;ToolTip, :, mouseX+50, 1000, 2
	videoRow := 0
	videoCol := 0
	MouseGetPos, mouseX, mouseY
	TL := []
	BR := []

	While, 1 {

		MouseMove, (mouseX + (vidDistX*videoRow)), (mouseY + (vidDistY*videoCol))
		click
		sleep 225
		;ToolTip, TL, mouseX, mouseY, 8
		;ToolTip, BR, mouseX+50, 1000, 9
		TL := [(mouseX-25 + (vidDistX*videoRow)), (mouseY * (videoCol+1))]
		BR := [(mouseX+35 + (vidDistX*videoRow)), A_ScreenHeight]

		if (videoRow == 3) {
			TL[1] := [(mouseX-250 + (vidDistX*videoRow))]
		}
		if(videoCol >= 2) {
			TL[2] := [mouseY-150]
			BR := [(mouseX+75 + (vidDistX*videoRow)), A_ScreenHeight]
		}

		ToolTip, TL., TL[1], TL[2], 8
		ToolTip, BR., BR[1], 1000, 9
		ImageSearch, imgX, imgY, TL[1], TL[2], BR[1], BR[2], %img%
		if ErrorLevel = 0				; Image detected
		{
			MouseMove, imgX, imgY
			sleep 10
			Click						; Clicks 'Not interested'
		}
		else{
			ToolTip, no vid found
			Break
		}
		videoRow++
		if(videoRow == 4) {
			videoCol++
			if(videoCol == 3) {
				Break
			}
			videoRow := 0
		}
	}
Return
F2::
	videoRow := 0
	videoCol := 0
	MouseGetPos, mouseX, mouseY
	TL := [(mouseX-25 + (vidDistX*videoRow)), (mouseY * (videoCol+1))]
	BR := [(mouseX+25 + (vidDistX*videoRow)), (mouseY + (250*(videoCol+1)))]

	ToolTip, TL., TL[1], TL[2], 8
	ToolTip, BR., BR[1], BR[2], 9
Return