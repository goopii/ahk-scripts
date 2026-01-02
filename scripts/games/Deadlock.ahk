#Requires AutoHotkey v2.0
#SingleInstance
#MaxThreadsPerHotkey 2
; WinSetTitle "DEADLOCK_HOTKEYS"

; PixelSearch &OutputVarX, &OutputVarY, X1, Y1, X2, Y2, ColorID , Variation


ability_1_key := "e"
ability_2_key := "XButton2"
ability_3_key := "q"
ability_4_key := "c"

cancel_key := "-"


; 1585 671

; d0c

; Original resolution
original_width := 2560
original_height := 1440

; Calculate scaling factor for current resolution
scale_x := A_ScreenWidth / original_width
scale_y := A_ScreenHeight / original_height

ability_1_x := 1099 * scale_x
ability_2_x := 1219 * scale_x
ability_3_x := 1339 * scale_x
ability_4_x := 1459 * scale_x

ability_23_y := 1395 * scale_y
ability_14_y := 1417 * scale_y

; WHITE
color_off_cooldown := 0xc6c2c7
; GRAY
color_on_cooldown := 0x2b2519
; PINK
color_active := 0xc2a9d9
; SUGGESTED BACKGROUND BLUE
color_suggested_background := 0x375c93
; SUGGESTED TEXT WHITE
color_suggested_text := 0xffdef7

#HotIf WinActive("ahk_exe project8.exe")
*e:: {
    CoordMode "Pixel", "Screen"
    if PixelSearch(&Px, &Py, ability_1_x, ability_14_y, ability_1_x, ability_14_y, color_off_cooldown, 0)
        Send "{" ability_1_key "}"
    else
        Send "{" cancel_key "}"
}

*XButton2:: {
    CoordMode "Pixel", "Screen"
    if PixelSearch(&Px, &Py, ability_2_x, ability_23_y, ability_2_x, ability_23_y, color_off_cooldown, 0)
        Send "{" ability_2_key "}"
    else
        Send "{" cancel_key "}"
}

*q:: {
    CoordMode "Pixel", "Screen"
    if PixelSearch(&Px, &Py, ability_3_x, ability_23_y, ability_3_x, ability_23_y, color_off_cooldown, 0)
        Send "{" ability_3_key "}"
    else
        Send "{" cancel_key "}"
}

*c:: {
    CoordMode "Pixel", "Screen"
    if PixelSearch(&Px, &Py, ability_4_x, ability_14_y, ability_4_x, ability_14_y, color_off_cooldown, 0)
        Send "{" ability_4_key "}"
    else
        Send "{" cancel_key "}"
}

; PixelSearch(&Px, &Py, ability_3_x, ability_23_y, ability_3_x, ability_23_y, color_active, 10)
; PixelSearch(&Px, &Py, ability_3_x, ability_23_y, ability_3_x, ability_23_y, color_on_cooldown, 100)
