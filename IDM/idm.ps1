#Installer
iwr -uri "https://github.com/HimadriChakra12/IDM-Crack/releases/download/6.42/idman642build22.exe" -OutFile "$env:TEMP/IDM.exe"
start-process "$env:TEMP/IDM.exe" -wait
start-process "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
Get-Process IDMan -ErrorAction SilentlyContinue | Stop-Process
#reg
iwr -uri "https://github.com/HimadriChakra12/IDM-Crack/releases/download/6.42/DownloadManager.reg" -OutFile "$env:TEMP/DownloadManager.reg"
start-process "$env:TEMP/DownloadManager.reg" -wait
#Zip
iwr -uri "https://github.com/HimadriChakra12/IDM-Crack/archive/refs/heads/main.zip" -OutFile "$env:TEMP/IDM.zip" 
expand-archive "$env:TEMP/IDM.zip" "$env:TEMP/IDM"
copy-item "$env:TEMP/IDM/IDM-Crack-main" "C:\Program Files (x86)\Internet Download Manager" -recurse 
start-process "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
