#Requires AutoHotkey v2.0

GetDefaultEditorPath() {
  RawValue := RegRead("HKCU\Software\Classes\AutoHotkeyScript\shell\edit\command")
  CleanPath := StrReplace(RawValue, '"') ; Remove all quotes
  _EditorPath := StrReplace(CleanPath, ' %1') ; Remove the argument suffix
  return _EditorPath
}

GetDefaultEditorExe() {
  SplitPath(GetDefaultEditorPath(), &_EditorExe)
  return _EditorExe
}