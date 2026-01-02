#Requires AutoHotkey v2.0

class AutoClicker {
    isClicking := false
    clickType := "Left"
    interval := 100

    __New() {
        ; Initialize the GUI
        this.Gui := Gui()
        this.Gui.Add("Text",, "Select Click Type:")
        
        this.clickTypeDropdown := this.Gui.Add("DropDownList", "w150", "Left|Right|Middle")
        this.clickTypeDropdown.Value := "Left"
        
        this.Gui.Add("Text",, "Click Interval (ms):")
        this.intervalInput := this.Gui.Add("Edit", "w150", "100")
        
        startButton := this.Gui.Add("Button", "w150", "Start")
        stopButton := this.Gui.Add("Button", "w150", "Stop")
        
        ; Assign actions to buttons
        startButton.OnEvent("Click", ObjBindMethod(this, "StartClicker"))
        stopButton.OnEvent("Click", ObjBindMethod(this, "StopClicker"))
        
        this.Gui.Show
    }

    StartClicker() {
        ; Retrieve values from the GUI
        this.clickType := this.clickTypeDropdown.Value
        this.interval := this.intervalInput.Value
        
        ; Start the autoclick timer
        this.isClicking := true
        SetTimer(ObjBindMethod(this, "AutoClick"), this.interval)
    }

    AutoClick() {
        ; Execute click if autoclicking is active
        if this.isClicking {
            Click(this.clickType)
        }
    }

    StopClicker() {
        ; Stop the autoclick timer
        this.isClicking := false
        SetTimer(ObjBindMethod(this, "AutoClick"), Off)
    }
}

; Instantiate the AutoClicker class
autoClicker := AutoClicker()

; Close the script when the GUI is closed
autoClicker.Gui.OnEvent("Close", (*) => ExitApp())
