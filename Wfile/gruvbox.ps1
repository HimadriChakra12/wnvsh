$tmp = "$env:TEMP/Gruvbox.zip" 
$tmpf = "$env:TEMP/Gruvbox" 
$tmpt = "$env:TEMP/ThemeTool.exe" 
if (test-path $tmpt){
    if (-not(Test-path $tmp)){
        iwr -uri "https://github.com/HimadriChakra12/Gruvbox-Windows/archive/refs/heads/main.zip" -OutFile "$tmp"
    }
    if (-not(Test-path $tmpf)){
        expand-archive "$tmp" "$tmpf"
    }
    $idmpack = @(
            @{ path = "$env:TEMP/Gruvbox/Gruvbox-Windows-main\Gruvbox " },
            @{ path = "$env:TEMP/Gruvbox/Gruvbox-Windows-main\Gruvbox Dark.theme " },
            @{ path = "$env:TEMP/Gruvbox/Gruvbox-Windows-main\Gruvbox Day.theme  " },
            @{ path = "$env:TEMP/Gruvbox/Gruvbox-Windows-main\Gruvbox Night.theme" },
            @{ path = "$env:TEMP/Gruvbox/Gruvbox-Windows-main\gruvlace Dark.theme " },
            @{ path = "$env:TEMP/Gruvbox/Gruvbox-Windows-main\gruvlace Day.theme  " }
            @{ path = "$env:TEMP/Gruvbox/Gruvbox-Windows-main\gruvlace Night.theme" }
            )
# Copy each file to the IDM install directory
        foreach ($id in $idmpack) {
            Copy-Item $id.path -Destination "C:\Windows\Resources\Themes" -Force
        }
    get-childitem "C:\Windows\Resources\Themes" -name
        start-process "$env:TEMP/ThemeTool.exe"  -verb runas
} else{
        iwr -uri "https://github.com/HimadriChakra12/Gruvbox-Windows/releases/download/1.0.0/ThemeTool.exe" -OutFile "$env:TEMP/ThemeTool.exe" 
        start-process "$env:TEMP/ThemeTool.exe"  -verb runas
}
