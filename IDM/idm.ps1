# Installer
iwr -Uri "https://github.com/HimadriChakra12/IDM-Crack/releases/download/6.42/idman642build22.exe" -OutFile "$env:TEMP\IDM.exe"
Start-Process "$env:TEMP\IDM.exe" -ArgumentList "/S" -Wait -NoNewWindow
Start-Process "C:\Program Files (x86)\Internet Download Manager\IDMan.exe" 
Get-Process IDMan -ErrorAction SilentlyContinue | Stop-Process

# Registry file
iwr -Uri "https://github.com/HimadriChakra12/IDM-Crack/releases/download/6.42/DownloadManager.reg" -OutFile "$env:TEMP\DownloadManager.reg"
Start-Process "$env:TEMP\DownloadManager.reg" -Wait

# Download and extract crack files
iwr -Uri "https://github.com/HimadriChakra12/IDM-Crack/archive/refs/heads/main.zip" -OutFile "$env:TEMP\IDM.zip"
Expand-Archive "$env:TEMP\IDM.zip" "$env:TEMP\IDM"

# List of crack files to copy
$idmpack = @(
    @{ path = "$env:TEMP\IDM\IDM-Crack-main\GlobalErrors.log" },
    @{ path = "$env:TEMP\IDM\IDM-Crack-main\idman.chm" },
    @{ path = "$env:TEMP\IDM\IDM-Crack-main\IDMan.exe" },
    @{ path = "$env:TEMP\IDM\IDM-Crack-main\IDMIECC.dll" },
    @{ path = "$env:TEMP\IDM\IDM-Crack-main\license.txt" },
    @{ path = "$env:TEMP\IDM\IDM-Crack-main\Uninstall.exe" }
)

# Copy each file to the IDM install directory
foreach ($id in $idmpack) {
    Copy-Item $id.path -Destination "C:\Program Files (x86)\Internet Download Manager" -Force
}

# Final launch
Start-Process "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
