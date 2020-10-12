powershell -File ".\script.ps1"

@echo off
Title Kill and restart Explorer.exe and restore all the windows by Hackoo 2020
Color 0A
Set "VBSFILE=%~dpn0.vbs"
> "%VBSFILE%" (
    echo Wscript.Echo Opened_Folders
    echo Function Opened_Folders
    echo    Dim objShellApp,wFolder,Open_Folder,F
    echo    Set objShellApp = CreateObject("Shell.Application"^)
    echo    For Each wFolder In objShellApp.Windows
    echo        Open_Folder = wFolder.document.Folder.Self.Path
    echo        F = F ^& Open_Folder ^& vbcrlf
    echo    Next
    echo    Opened_Folders = F
    echo End Function
)
REM  Populate the array with existent and opened folders
SetLocal EnableDelayedExpansion
Set /a Count=0
for /f "delims=" %%a in ('Cscript //NoLogo "%VBSFILE%"') do (
    Set /a Count+=1
    Set "Folder[!Count!]=%%a"
)
Taskkill /f /IM "explorer.exe"
Timeout /T 1 /NoBreak>nul
Start Explorer.exe
rem Restore all folders before killing explorer process
for /L %%i in (1,1,%Count%) do Explorer "!Folder[%%i]!"
exit
