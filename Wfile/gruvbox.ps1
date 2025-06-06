$tmp = "$env:TEMP/Gruvbox.zip" 
$tmpf = "$env:TEMP/Gruvbox" 
if (-not(Test-path $tmp){
iwr -uri "https://github.com/HimadriChakra12/Gruvbox-Windows/archive/refs/heads/main.zip" -OutFile "$tmp"
}
if (-not(Test-path $tmpf){
expand-archive "$tmp" "$tmpf"
}
copy-item "$env:TEMP/Gruvbox/Gruvbox-Windows-main" "C:\Windows\Resources\Themes" -recurse 

iwr -uri "https://github.com/HimadriChakra12/Gruvbox-Windows/releases/download/1.0.0/ThemeTool.exe" -OutFile "$env:TEMP/ThemeTool.exe" 
start-process "$env:TEMP/ThemeTool.exe"  -verb runas
