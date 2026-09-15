#NoEnv
#SingleInstance Force

; 1. Request Admin Rights
if not A_IsAdmin {
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

; 2. Choose Destination (Default vs Custom)
DefaultDir := "C:\win custom widget\power plan switcher"
MsgBox, 36, Installation Location, Would you like to select a custom install folder?`n`nClick 'Yes' to browse, or 'No' to use the default:`n%DefaultDir%

IfMsgBox, Yes
{
    FileSelectFolder, SelectedDir, *C:\, 3, Select Folder to Install Power Plan Switcher:
    if (SelectedDir = "") ; User clicked Cancel
        ExitApp
    TargetDir := SelectedDir . "\PowerPlanSwitcher"
}
else
{
    TargetDir := DefaultDir
}

; 3. Create Target Directory
FileCreateDir, %TargetDir%

; 4. Extract Switcher EXE and Registry Remover File
FileInstall, PowerPlanSwitcher.exe, %TargetDir%\PowerPlanSwitcher.exe, 1
FileInstall, registry setting remover.reg, %TargetDir%\registry setting remover.reg, 1

; 5. Dynamically Generate "registry setting.reg" with the exact selected path
RegFilePath := TargetDir . "\registry setting.reg"
FileDelete, %RegFilePath%

; Convert single backslashes to double backslashes for Registry format
StringReplace, EscapedPath, TargetDir, \, \\, All
EscapedExePath := EscapedPath . "\\PowerPlanSwitcher.exe"

RegContent = 
(
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\Background\shell\PowerPlanSwitcher]
@="Switch Power Plan"
"Icon"="powercpl.dll"
"Position"="Middle"

[HKEY_CLASSES_ROOT\Directory\Background\shell\PowerPlanSwitcher\command]
@="\"%EscapedExePath%\""
)

FileAppend, %RegContent%, %RegFilePath%

; 6. Silently Merge Registry
RunWait, regedit.exe /s "%RegFilePath%"

MsgBox, 64, Install Complete, Power Plan Switcher installed successfully to:`n%TargetDir%
ExitApp