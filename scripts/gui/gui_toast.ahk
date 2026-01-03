#Requires AutoHotkey v2.0

class Toast {
    static gui := ""
    static timer := ""
    static duration := 3000
    static margin := 20

    static Show(title := "", message := "", duration := 3000) {
        if (this.gui == "") {
            this.gui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
            this.gui.BackColor := "1a1a1a"
            this.gui.SetFont("s10 Bold", "Segoe UI")

            titleCtrl := this.gui.AddText("x15 y12 w300 h20 cFFFFFF", "")
            this.gui.SetFont("s9", "Segoe UI")
            msgCtrl := this.gui.AddText("x15 y35 w300 h40 cCCCCCC", "")

            this.gui["title"] := titleCtrl
            this.gui["message"] := msgCtrl
        }

        this.duration := duration
        this.gui["title"].Value := title
        this.gui["message"].Value := message

        screen_w := A_ScreenWidth
        screen_h := A_ScreenHeight
        gui_w := 330
        gui_h := 90
        x_pos := screen_w - gui_w - this.margin
        y_pos := screen_h - gui_h - this.margin

        this.gui.Show(Format("x{} y{} w{} h{} NoActivate", x_pos, y_pos, gui_w, gui_h))

        WinSetTransparent(0, this.gui)
        this.FadeIn()

        if (this.timer) {
            SetTimer(this.timer, 0)
        }
        this.timer := ObjBindMethod(this, "FadeOut")
        SetTimer(this.timer, -this.duration)
    }

    static FadeIn() {
        loop 10 {
            WinSetTransparent(255 * (A_Index / 10), this.gui)
            Sleep(10)
        }
    }

    static FadeOut() {
        loop 10 {
            WinSetTransparent(255 * (1 - A_Index / 10), this.gui)
            Sleep(10)
        }
        this.gui.Hide()
        WinSetTransparent(255, this.gui)
    }

    static Hide() {
        if (this.timer) {
            SetTimer(this.timer, 0)
            this.timer := ""
        }
        this.gui.Hide()
    }
}

ShowToast(title := "", message := "", duration := 3000) => Toast.Show(title, message, duration)