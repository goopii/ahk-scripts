#Requires AutoHotkey v2.0

; Check for value in array
; array - The array to search
; valueToFind - The value to find
; Returns the index of the value if found, false otherwise
GetIndexOfValue(array, valueToFind) {
  for index, currentValue in array {
    if currentValue = valueToFind
      return index
  }
  return false
}