#MaxThreadsPerHotkey 1
#SingleInstance Force
#Requires AutoHotkey v2.0
;==============================================================================
; LOGGING SYSTEM
;==============================================================================
; Global variables for logging
global log_enabled := true
global log_paused := false
global log_gui := Gui()
global log_buffer := ""
global log_max_lines := 100
global log_entries := []
global log_display := ""

; Enable or disable logging
log_setState(state := "toggle") {
  global log_enabled
  if (state == "toggle") {
    log_enabled := !log_enabled
  }
  else If (state == false) {
    log_enabled := false
  }
  else If (state == true){
    log_enabled := true
  }
}

; Log a message to the log GUI
log(message) {
  global log_enabled, log_paused, log_display, log_entries, log_max_lines, log_gui
  if (!log_enabled || log_paused) {
    return
  }
  ; Initialize GUI on first use
  if (!log_display)
    log_display := log_init()

  ; Format the log message with timestamp - fixed FormatTime syntax
  timestamp := FormatTime(A_Now, "HH:mm:ss")
  log_msg := "[" timestamp "] " message

  ; Add to log entries array, maintain max size
  log_entries.Push(log_msg)
  if (log_entries.Length > log_max_lines)
    log_entries.RemoveAt(1)

  ; Update display if not paused
  log_updateDisplay(log_msg)

  ; Ensure GUI is visible
  if (!WinExist("ahk_id " log_gui.Hwnd))
    log_gui.Show("w520 h380")

  return message  ; Return message for chaining
}

; Initialize the logging GUI
log_init() {
  global log_enabled, log_gui, log_display
  if (!log_enabled) {
    return
  }
  ; Configure basic GUI properties
  log_gui.Opt("+AlwaysOnTop +Resize")
  log_gui.Title := "Script Log"
  log_gui.SetFont("s10", "Consolas")

  ; Add control buttons in toolbar style at top
  pause_btn := log_gui.AddButton("x10 y10 w120 h25", "Pause Logging")
  clear_btn := log_gui.AddButton("x140 y10 w120 h25", "Clear Log")
  close_btn := log_gui.AddButton("x270 y10 w120 h25", "Close")

  ; Add separator line below buttons
  log_gui.AddText("x0 y40 w520 h1 +0x10")  ; Horizontal line

  ; Add log display control below toolbar
  log_gui.AddText("x10 y45 w500 h20", "Log Output:")
  log_display := log_gui.AddEdit("x10 y65 w500 h305 +ReadOnly +Multi +VScroll", "")

  ; Set button actions
  pause_btn.OnEvent("Click", log_togglePause)
  clear_btn.OnEvent("Click", log_clear)
  close_btn.OnEvent("Click", log_close)

  ; Handle window close
  log_gui.OnEvent("Close", log_close)

  ; Calculate position for top right corner
  gui_w := 200  ; GUI width
  gui_h := 400  ; GUI height
  screen_w := A_ScreenWidth
  screen_h := A_ScreenHeight
  x_pos := screen_w - gui_w - 50  ; 20px padding from right edge
  y_pos := 50                      ; 20px padding from top edge

  ; Show the GUI in top right corner
  log_gui.Show(Format("x{} y{} w{} h{}", x_pos, y_pos, gui_w, gui_h))

  return log_display
}

; Update the log display with current entries
log_updateDisplay(latest_msg := "") {
  global log_enabled, log_paused, log_gui
  if (!log_enabled) {
    return
  }
  ; If paused, don't update unless it's a control message
  if (log_paused && !InStr(latest_msg, "--- Logging"))
    return

  ; Add the current message if provided
  if (latest_msg != "") {
    log_gui["Edit1"].Value := log_gui["Edit1"].Value . latest_msg . "`r`n"

    editCtrl := log_gui["Edit1"].Hwnd  ; Get the handle to the edit control
    SendMessage(0x115, 7, 0, editCtrl)  ; WM_VSCROLL with SB_BOTTOM
  }
}

; Button handlers
log_togglePause(*) {
  global log_paused, log_gui
  log_paused := !log_paused

  ; Update button text
  if (log_paused)
    log_gui["Button1"].Text := "Resume Logging"
  else
    log_gui["Button1"].Text := "Pause Logging"

  ; Add pause status to log
  if (log_paused)
    log_updateDisplay("--- Logging Paused ---")
  else
    log_updateDisplay("--- Logging Resumed ---")
}

log_clear(*) {
  global log_entries, log_gui
  log_entries := []
  log_gui["Edit1"].Value := ""
}

log_close(*) {
  global log_gui
  log_gui.Hide()
}