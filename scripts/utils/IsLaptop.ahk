#Requires AutoHotkey v2.0

is_laptop := IsLaptop()
; Check if system is a laptop by detecting battery presence
IsLaptop() {
    try {
        battery := ComObject("WbemScripting.SWbemLocator").ConnectServer().ExecQuery(
            "Select * from Win32_Battery"
        )

        for _ in battery {
            return true
        }
    } catch Error {
        ; If COM object creation fails, fallback to checking power status
        DllCall("kernel32.dll\GetSystemPowerStatus", "Ptr", Buffer(12))
        return DllCall("kernel32.dll\GetSystemPowerStatus", "Ptr", Buffer(12)) != 0
    }

    return false
}
; Get device-specific value based on system type
GetDeviceValue(desktopValue, laptopValue) {
    global is_laptop
    return is_laptop ? laptopValue : desktopValue
}

is_laptop := IsLaptop()