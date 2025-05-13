#Requires AutoHotkey v2.0

; Check if array contains value
HasValue(arr, val) {
  for i, v in arr {
    if v = val
      return i
  }
  return false
}