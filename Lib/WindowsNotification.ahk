#Requires AutoHotkey v2.0

WindowsNotification(title := "", message := "", iconType := 1, duration := 5000) {
    iconStr := iconType = 1 ? "Iconi" : (iconType = 2 ? "Icon!" : (iconType = 3 ? "Iconx" : ""))
    TrayTip(message, title, iconStr)
    if (duration > 0) {
        SetTimer(HideTrayTip, -duration)
    }
}

HideTrayTip() {
    TrayTip()
}

