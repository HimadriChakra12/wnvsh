$regContent = @'
Windows Registry Editor Version 5.00

; --- Begin: capstoesc.reg ---

[...CAPS_TO_ESC_CONTENT...]

; --- End: capstoesc.reg ---


; --- Begin: Context Menu (No Icons) ---

[...CONTEXT_MENU_CONTENT...]

; --- End: Context Menu (No Icons) ---
'@

# Save combined registry content to a temporary file
$tempRegPath = "$env:TEMP\combined.reg"
$regContent | Out-File -FilePath $tempRegPath -Encoding Unicode

# Import the .reg file silently
Start-Process "regedit.exe" -ArgumentList "/s `"$tempRegPath`"" -Wait
Write-Output "Registry entries successfully applied from: $tempRegPath"

