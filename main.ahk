#SingleInstance off

#Include lib/LetUserSelectRect.ahk
#Include lib/Gdip.ahk
#Include lib/SaveScreenshot.ahk

CoordMode, Mouse, Screen

; ---
; GUI
; ---

value := 1000
Gui, 5:Add, Button, gSelectFrame, Select Frame
Gui, 5:+AlwaysOnTop
Gui, 5:Add, Text, vmytext, Delay Period (ms): %value%
Gui, 5:Add, Slider, vvalue Range0-1000 gUpdateValue AltSubmit, %value%
Gui, 5:Add, Button, gSolve, Solve
Gui, 5:Show
return

; -------
; ACTIONS
; -------

SelectFrame:
LetUserSelectRect(X1, Y1, X2, Y2)
return

UpdateValue:
GuiControlGet, value
GuiControl, , mytext, Delay Period (ms): %value%
return

Solve:
; Take a screenshot of the puzzle
screenshot  := A_ScriptDir "\tmp\screenshot.png"
clickscript := A_ScriptDir "\tmp\clicks.ahk"
width :=  X2 - X1
height := Y2 - Y1
screen := X1 . "|" . Y1 . "|" . width . "|" . height ; X|Y|W|H
SaveScreenshot(screenshot, screen)
Sleep, 100
; Solve the puzzle using R
RunWait "Rscript.exe" solver.R %screenshot% %X1% %Y1% %value% %clickscript%
   , A_ScriptDir, Hide
Sleep, 100
; Run the solution
Run, "AutoHotkey.exe" %clickscript%, A_ScriptDir, Hide
return

