#Requires AutoHotkey v2.0

; https://github.com/xanderfrangos/twinkle-tray
TwinkleTrayOffset(offset) {
  appPath := EnvGet("LocalAppData") "\Programs\twinkle-tray\Twinkle Tray.exe"
  args := " --All --Overlay --Offset=" offset
  if FileExist(appPath) {
    Run('"' appPath '"' args)
  }
  else {
    Run("Twinkle-Tray.exe" args)
  }
}