#MaxThreadsPerHotkey 1
#SingleInstance Force
#Requires AutoHotkey v2.0

class Logger {
    static enabled := true
    static paused := false
    static gui := Gui()
    static buffer := ""
    static max_lines := 100
    static entries := []
    static display := ""

    static SetState(state := "toggle") {
        if (state == "toggle") {
            this.enabled := !this.enabled
        }
        else if (state == false) {
            this.enabled := false
        }
        else if (state == true) {
            this.enabled := true
        }
    }

    static Log(message) {
        if (!this.enabled || this.paused) {
            return
        }

        ; Initialize GUI on first use
        if (!this.display)
            this.display := this.Init()

        ; Format the log message with timestamp
        timestamp := FormatTime(A_Now, "HH:mm:ss")
        log_msg := "[" timestamp "] " message

        ; Add to log entries array, maintain max size
        this.entries.Push(log_msg)
        if (this.entries.Length > this.max_lines)
            this.entries.RemoveAt(1)

        ; Update display if not paused
        this.UpdateDisplay(log_msg)

        ; Ensure GUI is visible
        if (!WinExist("ahk_id " this.gui.Hwnd))
            this.gui.Show("w520 h380")

        return message  ; Return message for chaining
    }

    static Init() {
        if (!this.enabled) {
            return
        }

        ; Configure basic GUI properties
        this.gui.Opt("+AlwaysOnTop +Resize")
        this.gui.Title := "Script Log"
        this.gui.SetFont("s10", "Consolas")

        ; Add control buttons in toolbar style at top
        pause_btn := this.gui.AddButton("x10 y10 w120 h25", "Pause Logging")
        clear_btn := this.gui.AddButton("x140 y10 w120 h25", "Clear Log")

        ; Add separator line below buttons
        this.gui.AddText("x0 y40 w520 h1 +0x10")  ; Horizontal line

        ; Add log display control below toolbar
        this.gui.AddText("x10 y45 w500 h20", "Log Output:")
        this.display := this.gui.AddEdit("x10 y65 w500 h305 +ReadOnly +Multi +VScroll", "")

        ; Set button actions
        pause_btn.OnEvent("Click", this.TogglePause.Bind(this))
        clear_btn.OnEvent("Click", this.Clear.Bind(this))

        ; Handle window close
        this.gui.OnEvent("Close", this.Close.Bind(this))

        ; Calculate position for top right corner
        gui_w := 400  ; GUI width
        gui_h := 600  ; GUI height
        screen_w := A_ScreenWidth
        screen_h := A_ScreenHeight
        x_pos := screen_w - gui_w - 50  ; 20px padding from right edge
        y_pos := 50                      ; 20px padding from top edge
        gui_pos := Format("x{} y{} w{} h{}", x_pos, y_pos, gui_w, gui_h)
        ; Show the GUI in top right corner
        this.gui.Show(gui_pos "NoActivate")

        return this.display
    }

    static UpdateDisplay(latest_msg := "") {
        if (!this.enabled) {
            return
        }

        ; If paused, don't update unless it's a control message
        if (this.paused && !InStr(latest_msg, "--- Logging"))
            return

        ; Add the current message if provided
        if (latest_msg != "") {
            this.gui["Edit1"].Value := this.gui["Edit1"].Value . latest_msg . "`r`n"

            editCtrl := this.gui["Edit1"].Hwnd  ; Get the handle to the edit control
            SendMessage(0x115, 7, 0, editCtrl)  ; WM_VSCROLL with SB_BOTTOM
        }
    }

    static TogglePause(*) {
        this.paused := !this.paused

        ; Update button text
        if (this.paused)
            this.gui["Button1"].Text := "Resume Logging"
        else
            this.gui["Button1"].Text := "Pause Logging"

        ; Add pause status to log
        if (this.paused)
            this.UpdateDisplay("--- Logging Paused ---")
        else
            this.UpdateDisplay("--- Logging Resumed ---")
    }

    static Clear(*) {
        this.entries := []
        this.gui["Edit1"].Value := ""
    }

    static Close(*) {
        this.gui.Hide()
    }
}

; Create global functions for backward compatibility
log_setState(state := "toggle") => Logger.SetState(state)
log(message) => Logger.Log(message)