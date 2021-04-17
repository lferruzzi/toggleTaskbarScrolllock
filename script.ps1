$p='HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'
$v=(Get-ItemProperty -Path $p).Settings

if ($v[8] -eq 2) {
   # TV Mode 
   $v[8]=3
   &Set-ItemProperty -Path $p -Name Settings -Value $v
   # Set the screen saver to "Ribbons"
   reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d C:\Windows\system32\Ribbons.scr /f
} else {
   # Monitor Mode 
   $v[8]=2
   &Set-ItemProperty -Path $p -Name Settings -Value $v
   # Set the screen saver to "None"
   reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v SCRNSAVE.EXE /f
}
