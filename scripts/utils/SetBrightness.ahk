#Requires AutoHotkey v2.0
#Include IsLaptop.ahk

SetBrightness(delta) {
    DllCall("GetCursorPos", "uint64*", &point := 0)
    hMon := DllCall("MonitorFromPoint", "uint64", point, "uint", 0x2, "ptr")
    
    if IsLaptop() {
        if TryIOCTL(hMon, delta)
            return
    }
    
    TryDDCCI(hMon, delta)
}

TryIOCTL(hMon, delta) {
    MIEX := Buffer(40 + 64)
    NumPut("uint", MIEX.size, MIEX)
    
    if !DllCall("GetMonitorInfo", "ptr", hMon, "ptr", MIEX)
        return false
    
    MonName := StrGet(MIEX.ptr + 40, 32)
    ddAdapter := Buffer(840, 0)
    NumPut("uint", ddAdapter.size, ddAdapter)
    
    while DllCall("EnumDisplayDevicesW", "ptr", 0, "uint", A_Index - 1, "ptr", ddAdapter, "uint", 0) {
        StateFlags := NumGet(ddAdapter, 324, "uint")
        
        if ((StateFlags & 0x9) != 0x1)
            continue
        
        DeviceName := StrGet(ddAdapter.ptr + 4, 32 + 2, "UTF-16")
        
        if (DeviceName != MonName)
            continue
        
        ddMonitor := Buffer(840, 0)
        NumPut("uint", ddMonitor.size, ddMonitor)
        
        while DllCall("EnumDisplayDevicesW", "str", DeviceName, "uint", A_Index - 1, "ptr", ddMonitor, "uint", 1) {
            StateFlags := NumGet(ddMonitor, 324, "uint")
            
            if !(StateFlags & 0x1)
                continue
            
            DeviceID := StrGet(ddMonitor.ptr + 328, 128 + 2, "UTF-16")
            
            hLCD := DllCall("CreateFile", "str", DeviceID, "uint", 0xC0000000, "uint", 0x3, "ptr", 0, "uint", 0x3, "uint", 0, "ptr", 0, "ptr")
            
            if hLCD = -1
                return false
            
            SupportedBrightness := Buffer(256, 0)
            Brightness := Buffer(3, 0)
            DevVideo := 0x00000023, BuffMethod := 0, Fileacces := 0
            
            NumPut("UChar", 0x03, Brightness, 0)
            
            DllCall("DeviceIoControl", "ptr", hLCD, "uint", (DevVideo << 16 | 0x126 << 2 | BuffMethod << 14 | Fileacces), "ptr", 0, "uint", 0, "ptr", Brightness, "uint", 3, "uint*", &BrightnessSize := 0, "ptr", 0)
            
            DllCall("DeviceIoControl", "ptr", hLCD, "uint", (DevVideo << 16 | 0x125 << 2 | BuffMethod << 14 | Fileacces), "ptr", 0, "uint", 0, "ptr", SupportedBrightness, "uint", 256, "uint*", &SupportedBrightnessSize := 0, "ptr", 0)
            
            ACBrightness := NumGet(Brightness, 1, "UChar")
            DCBrightness := NumGet(Brightness, 2, "UChar")
            MaxIndex := SupportedBrightnessSize - 1
            
            CurrentIndex := 0
            loop SupportedBrightnessSize {
                if (Max(ACBrightness, DCBrightness) = NumGet(SupportedBrightness, A_Index - 1, "UChar")) {
                    CurrentIndex := A_Index - 1
                    break
                }
            }
            
            NewIndex := Max(0, Min(MaxIndex, CurrentIndex + delta))
            NewBrightness := NumGet(SupportedBrightness, NewIndex, "UChar")
            
            NumPut("UChar", 0x03, Brightness, 0)
            NumPut("UChar", NewBrightness, Brightness, 1)
            NumPut("UChar", NewBrightness, Brightness, 2)
            
            success := DllCall("DeviceIoControl", "ptr", hLCD, "uint", (DevVideo << 16 | 0x127 << 2 | BuffMethod << 14 | Fileacces), "ptr", Brightness, "uint", 3, "ptr", 0, "uint", 0, "ptr", 0, "ptr", 0)
            
            DllCall("CloseHandle", "ptr", hLCD)
            return success
        }
    }
    
    return false
}

TryDDCCI(hMon, delta) {
    static stored := Map()
    
    MIEX := Buffer(40 + 64)
    NumPut("uint", MIEX.size, MIEX)
    
    if !DllCall("GetMonitorInfo", "ptr", hMon, "ptr", MIEX)
        return false
    
    MonName := StrGet(MIEX.ptr + 40, 32)
    
    DllCall("dxva2\GetNumberOfPhysicalMonitorsFromHMONITOR", "ptr", hMon, "uint*", &PhysMons := 0)
    DllCall("dxva2\GetPhysicalMonitorsFromHMONITOR", "ptr", hMon, "uint", PhysMons, "ptr", PHYS_MONITORS := Buffer((A_PtrSize + 256) * PhysMons, 0))
    hPhysMon := NumGet(PHYS_MONITORS, 0, "ptr")
    
    if !stored.has(MonName) {
        retries := 0
        while !DllCall("dxva2\GetVCPFeatureAndVCPFeatureReply", "Ptr", hPhysMon, "uchar", 0x10, "ptr", 0, "uint*", &BrightnessCur := 0, "uint*", &BrightnessMax := 0) {
            if ++retries >= 6 {
                DllCall("dxva2\DestroyPhysicalMonitors", "uint", PhysMons, "ptr", PHYS_MONITORS)
                return false
            }
        }
        
        newBrightness := Max(0, Min(BrightnessMax, BrightnessCur + delta))
        stored[MonName] := [0, newBrightness, BrightnessMax]
    } else {
        BrightnessMax := stored[MonName][3]
        BrightnessCur := stored[MonName][2]
        newBrightness := stored[MonName][2] := Max(0, Min(BrightnessMax, BrightnessCur + delta))
    }
    
    SetBrightnessDelayed(b, bref, monitors) {
        if (b == %bref%)
            DllCall("dxva2\SetVCPFeature", "Ptr", NumGet(monitors, 0, "ptr"), "uchar", 0x10, "UInt", b)
        DllCall("dxva2\DestroyPhysicalMonitors", "uint", PhysMons, "ptr", monitors)
    }
    
    SetTimer SetBrightnessDelayed.bind(newBrightness, &newBrightness, PHYS_MONITORS), -1
    return true
}