Add-Type -AssemblyName System.Windows.Forms

$scrollLockKeyStatus = [System.Windows.Forms.Control]::IsKeyLocked('Scroll')

$keyBoardObject = New-Object -ComObject WScript.Shell 

if ($scrollLockKeyStatus -eq $false )  {
   $keyBoardObject.SendKeys("{SCROLLLOCK}") 
   &{$p='HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3';$v=(Get-ItemProperty -Path $p).Settings;$v[8]=3;&Set-ItemProperty -Path $p -Name Settings -Value $v}
} else {
    $keyBoardObject.SendKeys("{SCROLLLOCK}") 
    &{$p='HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3';$v=(Get-ItemProperty -Path $p).Settings;$v[8]=2;&Set-ItemProperty -Path $p -Name Settings -Value $v}
}
