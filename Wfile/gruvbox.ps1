iwr -uri "https://github.com/HimadriChakra12/Gruvbox-Windows/archive/refs/heads/main.zip" -OutFile "$env:TEMP/Gruvbox.zip" 
expand-archive "$env:TEMP/Gruvbox.zip" "$env:TEMP/Gruvbox"
copy-item "$env:TEMP/Gruvbox/Gruvbox-Windows-main" "C:\Windows\Resources\Themes" -recurse 

iwr -uri "https://github.com/HimadriChakra12/Gruvbox-Windows/releases/download/1.0.0/ThemeTool.exe" -OutFile "$env:TEMP/ThemeTool.exe" 
start-process "$env:TEMP/ThemeTool.exe" 
