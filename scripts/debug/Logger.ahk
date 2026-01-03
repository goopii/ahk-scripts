#MaxThreadsPerHotkey 1
#SingleInstance Force
#Requires AutoHotkey v2.0

class Logger {
    static enabled := true
    static gui := Gui()
    static buffer := ""
    static max_lines := 100
    static entries := []
    static display := ""

    static Init() {
        if (!this.enabled) {
            return
        }

        ; Configure basic GUI properties
        this.gui.Opt("+AlwaysOnTop +Resize")
        this.gui.Title := "Script Log"
        this.gui.SetFont("s10", "Consolas")

        ; Add clear button
        clear_btn := this.gui.AddButton("x10 y10 w120 h25", "Clear Log")
        keyhist_btn := this.gui.AddButton("x140 y10 w120 h25", "KeyHistory")

        ; Add separator line below buttons
        this.gui.AddText("x0 y40 w520 h1 +0x10")  ; Horizontal line

        ; Add log display control below toolbar
        this.gui.AddText("x10 y45 w500 h20", "Log Output:")
        this.display := this.gui.AddEdit("x10 y65 w500 h305 +ReadOnly +Multi +VScroll", "")

        ; Set button actions
        clear_btn.OnEvent("Click", this.gui_Clear.Bind(this))
        keyhist_btn.OnEvent("Click", (*) => KeyHistory())

        ; Handle window close
        this.gui.OnEvent("Close", this.gui_Close.Bind(this))

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

    ; Public methods
    static Log(message, caller := A_ThisHotkey) {
        if (!this.enabled) {
            return
        }

        ; Handle array input
        if (IsObject(message) && Type(message) == "Array") {
            arr_str := ""
            for index, element in message {
                arr_str .= element . (index == message.Length ? "" : ", ")
            }
            message := "[" arr_str "]"
        }

        ; Initialize GUI on first use
        if (!this.display)
            this.display := this.Init()

        ; Format the log message with timestamp
        timestamp := FormatTime(A_Now, "HH:mm:ss")
        ; "[" timestamp "] "
        log_msg := "[" caller "]: " message
        
        ; Add to log entries array, maintain max size
        this.entries.Push(log_msg)
        if (this.entries.Length > this.max_lines)
            this.entries.RemoveAt(1)

        ; Update display
        this.UpdateDisplay(log_msg)

        ; Ensure GUI is visible
        if (!WinExist("ahk_id " this.gui.Hwnd))
            this.gui.Show("w520 h380")

        return message  ; Return message for chaining
    }

    static LogState(state := "toggle") {
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
    static LogDisplay(state := "toggle") {
        if (state == "toggle") {
            if WinExist("ahk_id " Logger.gui.Hwnd)
                Logger.gui.Hide()
            else
                Logger.gui.Show()
        } else if (state == false) {
            Logger.gui.Hide()
        } else if (state == true) {
            Logger.gui.Show()
        }
    }
    ; Private methods
    static UpdateDisplay(latest_msg := "") {
        if (!this.enabled) {
            return
        }

        ; Add the current message if provided
        if (latest_msg != "") {
            this.gui["Edit1"].Value := this.gui["Edit1"].Value . latest_msg . "`r`n"

            editCtrl := this.gui["Edit1"].Hwnd  ; Get the handle to the edit control
            SendMessage(0x115, 7, 0, editCtrl)  ; WM_VSCROLL with SB_BOTTOM
        }
    }

    ; GUI methods
    static gui_Clear(*) {
        this.entries := []
        this.gui["Edit1"].Value := ""
    }

    static gui_Close(*) {
        this.gui.Hide()
    }
}

; Exported functions
Log(message, caller := A_ThisHotkey) => Logger.Log(message, caller)
LogState(state := "toggle") => Logger.LogState(state)
LogDisplay(state := "toggle") => Logger.LogDisplay(state)