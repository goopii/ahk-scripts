#MaxThreadsPerHotkey 1
#SingleInstance Force
#Requires AutoHotkey v2.0
GuiBorderToggle(show, color := "") {
  static borderWidth := 4
  global gui_border_on

  if (show) {
    ; Get monitor dimensions
    monitor := GetActiveMonitor()
    if (!monitor) {
      return
    }
    ; Create region string for border frame
    region := Format("0-0 {1}-{2} {3}-{4} {5}-{6} {7}-{8} {9}-{10}",
      monitor.w, 0, monitor.w, monitor.h, 0, monitor.h, 0, 0,
      borderWidth, borderWidth)
    region .= Format(" {1}-{2} {3}-{4} {5}-{6} {7}-{8}",
      monitor.w - borderWidth, borderWidth,
      monitor.w - borderWidth, monitor.h - borderWidth,
      borderWidth, monitor.h - borderWidth,
      borderWidth, borderWidth)

    ; Show GUI and apply region
    ; MsgBox("BackColor: " gui_border.BackColor " `nColor: " color)
    if color != "" { ; If a color is provided, use it
      gui_border.BackColor := color
    }
    else if gui_border.BackColor == "" { ; If no previous color exists, use white
      gui_border.BackColor := "FFFFFF"
    }
    ; Otherwise keep the existing color
    gui_border.Show(Format("x{1} y{2} w{3} h{4} NoActivate",
      monitor.x, monitor.y, monitor.w, monitor.h))
    WinSetRegion(region, gui_border)
    gui_border_on := true
    ; Monitor active window changes in a separate thread to update border
    SetTimer(MonitorActiveWindow, -1)
  } else {
    gui_border.Hide()
    gui_border_on := false
  }
}
MonitorActiveWindow() {
  static prevWin := ""

  while (gui_border_on) {
    try {
      if activeWin := WinGetID("A") {
        if (activeWin != prevWin) {
          GuiBorderToggle(true)
          prevWin := activeWin
        }
        WinWaitNotActive(activeWin)
      }
    } catch Error as e {
      ; Skip this iteration if window detection fails
      continue
    }
  }
}