WIKI:https: // www.autohotkey.com / docs / Hotkeys.htm
KEYLIST:https: // gist.github.com / csharpforevermore / 11348986
SCANCODES:https: // kbdlayout.info / kbdsw / scancodes + names ? arrangement = ISO105
        WINDOW NAME : https: // www.autohotkey.com / docs / misc / WinTitle.htm

    #MaxThreadsPerHotkey 1
    #SingleInstance Force
    #Requires AutoHotkey v2.
    A_MenuMaskKey := "vkE8"

    Symbol Identifiers:
        https: // www.autohotkey.com / docs / v2 / Hotkeys.htm
        + = shift
        ^ = ctrl
    ! = Alt
    # = Win
    < ^ > ! = AltGr
        * = Wildcard:
        Fire the hotkey even if extra modifiers are being held down.
            https: // www.autohotkey.com / boards / viewtopic.php ? t = 133133
                F2:: Send 'x' ; 1
                F3:: Send 'y' ; y
                x:: Send 1    ; 1
                $y:: Send 2   ; 2
                ~z:: Send 3   ; z3
                $ = Makes the hotkey use the keyboard hook.
                Prevents the Send function from triggering the hotkey.
                ~ = DON 'T block the key' s native function when hotkey activated.
                if at least one variant of that keyboard hotkey has the tilde modifier, that hotkey always uses the keyboard hook.
                    UP =
                        cause the hotkey to fire upon release of the key
                *LWin:: Send { LControl down }
                *LWin Up:: Send { LControl up }
                & = Used to create a hotkey using multiple keys.
                F20 & z::
                #HotIf is_WindowsKey_Held
                #HotIf WinActive("ahk_class Chrome_WidgetWin_1")
                gun := "pistol"
                ToolTip(modifiers key, x, y, id)
                ; MOUSE
                LButton
                RButton
                MButton
                XButton2 = forward
                XButton1 = backward
                MouseGetPos, mouseX, mouseY
                MouseMove, (mouseX + (100)), (mouseY + (100)) {
                    Blind
                }
                When { Blind } is the first item in the string, the program avoids releasing Alt / Control / Shift /
                Win if they started out in the down position.for example, the hotkey + s: : Send { Blind } abc would send ABC rather than abc because the user is
                    holding down the Shift key.
                {
                    Blind
                }
                is not supported by SendRaw and ControlSendRaw.Furthermore, it is not completely supported by SendPlay,
                especially when dealing with the modifier keys (Control, Alt, Shift, and Win).
                Blind mode
                The Blind mode can be enabled with { Blind }, which gives the script more control by disabling a number of things that are normally done automatically to make things work as expected.
                {
                    Blind
                }
                must be the first item in the string to enable the Blind mode.It has the following effects:
                -The Blind mode avoids releasing the modifier keys (Alt, Ctrl, Shift, and Win) if they started out in
                    the down position.
                    for example, the hotkey + s: : Send { Blind } abc would send ABC rather than abc because the user is
                        holding down Shift.
                        - Modifier keys are restored differently to allow a Send to turn off a hotkey 's modifiers even if the user is still physically holding them down.
                        for example, ^ space: : Send { Ctrl up } automatically pushes Ctrl back down if the user is
                            still physically holding Ctrl,
                            whereas ^ space: : Send { Blind } {
                            Ctrl up
                        }
                        allows Ctrl to be logically up even though it is physically down.
                SetStoreCapsLockMode is ignored; that is, the state of CapsLock is not changed.
                Menu masking is disabled.That is, Send omits the extra keystrokes that would otherwise be sent in order to prevent:
                1) Start Menu appearance during Win keystrokes (LWin / RWin); 2) menu bar activation during Alt keystrokes. However, the Blind mode does not prevent masking performed by the keyboard hook following activation of a hook hotkey.
    Send does not wait for Win to be released even if the text contains an L keystroke.This would normally be done to prevent Send from triggering the system "lock workstation" hotkey (
        Win + L).See Hotkeys for details.
            The Blind mode is used internally when remapping a key.for example, the remapping a: : b would produce: 1)
                "b"
                    when you type "a"; 2) uppercase "B" when you type uppercase "A"; and 3) Ctrl+B when you type Ctrl+A.
    {
        Blind
    }
    is not supported by SendRaw or ControlSendRaw; use {Blind}{Raw} instead.

    The Blind mode is not completely supported by SendPlay, especially when dealing with the modifier keys (Ctrl, Alt,
        Shift, and Win).
