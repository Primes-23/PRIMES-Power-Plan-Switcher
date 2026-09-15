#NoEnv
#SingleInstance Force
SetBatchLines, -1
Menu, Tray, NoStandard

; Automatically close script when clicking outside
OnMessage(0x0006, "WM_ACTIVATE")

; Theme Colors
DarkBg      := "121212"
BtnBg       := "4A0E0E"    ; Deep red for inactive plans
ActiveBtnBg := "8B0000"    ; Bright crimson for active plan
TextWhite   := "FFFFFF"
HeaderColor := "FF4D4D"

; Query Windows for all available power plans
RunWait, %ComSpec% /c powercfg /list > "%A_Temp%\p_plans.txt", , Hide
FileRead, planOutput, %A_Temp%\p_plans.txt
FileDelete, %A_Temp%\p_plans.txt

Plans := []
Loop, Parse, planOutput, `n, `r
{
    ; Match GUID, Plan Name, and check if active (*)
    if RegExMatch(A_LoopField, "i)GUID:\s*([a-f0-9\-]+)\s*\((.*?)\)(\s*\*|)", m)
    {
        guid := m1
        name := m2
        isActive := (InStr(A_LoopField, "*") ? true : false)
        Plans.Push({guid: guid, name: name, active: isActive})
    }
}

; Build Dark GUI Window
Gui, +AlwaysOnTop -Caption +ToolWindow +Border
Gui, Color, %DarkBg%
Gui, Font, s10 Bold, Segoe UI

; Title Header
Gui, Add, Text, x10 y12 w190 h20 c%HeaderColor% Center, SELECT POWER PLAN

; Dynamically Generate Buttons Based on Detected Plans
Gui, Font, s9 Bold, Segoe UI
yPos := 38

For index, plan in Plans {
    label := plan.active ? "   ●   " . plan.name : "   ○   " . plan.name
    bg    := plan.active ? ActiveBtnBg : BtnBg
    
    Gui, Add, Text, x12 y%yPos% w186 h30 c%TextWhite% Background%bg% 0x200 Left gSwitchPlan vBtn%index%, %label%
    yPos += 36
}

; Position GUI at Mouse Location
CoordMode, Mouse, Screen
MouseGetPos, mx, my
ShowX := mx - 10
ShowY := my - 10
WinHeight := yPos + 6

Gui, Show, x%ShowX% y%ShowY% w210 h%WinHeight%, Power Plan Switcher
return

; Dynamic Switcher Action
SwitchPlan:
    btnIndex := SubStr(A_GuiControl, 4) ; Extract button number (e.g., Btn1 -> 1)
    targetGuid := Plans[btnIndex].guid

    Run, powercfg -setactive %targetGuid%, , Hide

    ; Update Active States in Array & Refresh UI
    For idx, plan in Plans {
        isTarget := (idx = btnIndex)
        plan.active := isTarget
        
        newLabel := isTarget ? "   ●   " . plan.name : "   ○   " . plan.name
        newBg    := isTarget ? ActiveBtnBg : BtnBg

        GuiControl,, Btn%idx%, %newLabel%
        GuiControl, +Background%newBg%, Btn%idx%
        GuiControl, MoveDraw, Btn%idx%
    }
return

; Auto-close on click outside
WM_ACTIVATE(wParam) {
    if (wParam = 0) ; WA_INACTIVE
        ExitApp
}

GuiClose:
GuiEscape:
ExitApp