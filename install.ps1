if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    #if not it will run the command on admin
    Write-Warning "Running this script as Administrator!"
    Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "iwr -useb "https://tinyurl.com/hwnvsh" | iex "' -Verb RunAs
    exit
}

$path = "C:/mwshrooms/hyphws/wnvsh"
if (-not (test-path $path)){
    mkdir $path | out-null
}

iwr -uri "https://github.com/HimadriChakra12/wnvsh/releases/download/0.1.0/wnvsh.exe" -OutFile "$env:TEMP/wnvsh.exe" ; copy-item "$env:TEMP/wnvsh.exe" "C:/mwshrooms/hyphws/wnvsh/wnvsh.exe"

if (get-command gsudo){
    write-host "Already have gsudo" -ForegroundColor green
} else {
    PowerShell -Command "Set-ExecutionPolicy RemoteSigned -scope Process; [Net.ServicePointManager]::SecurityProtocol = 'Tls12'; iwr -useb https://raw.githubusercontent.com/gerardog/gsudo/master/installgsudo.ps1 | iex"
}

try{
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$path*"){
        [Environment]::SetEnvironmentVariable("Path", "$currentPath;$path", "User")
        Write-Host "wnvsh added to user PATH." -ForegroundColor cyan
    } else {
        Write-Host "wnvsh already in user PATH." -ForegroundColor green
    }
} catch {
    Write-Error "Error adding mingw to path: $($_.Exception.Message)"
}
