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
$idmpack = @(
@{ path = "C:\Users\himadri\AppData\Local\Temp\IDM\IDM-Crack-main\GlobalErrors.log"}
@{ path = "C:\Users\himadri\AppData\Local\Temp\IDM\IDM-Crack-main\idman.chm"}
@{ path = "C:\Users\himadri\AppData\Local\Temp\IDM\IDM-Crack-main\IDMan.exe"}
@{ path = "C:\Users\himadri\AppData\Local\Temp\IDM\IDM-Crack-main\IDMIECC.dll"}
@{ path = "C:\Users\himadri\AppData\Local\Temp\IDM\IDM-Crack-main\license.txt"}
@{ path = "C:\Users\himadri\AppData\Local\Temp\IDM\IDM-Crack-main\Uninstall.exe"}
)
foreach ($id in $idmpack){
copy-item "$($id.path)" "C:\Program Files (x86)\Internet Download Manager" -recurse 
}
start-process "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
