# Requires elevation
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Please run this script as Administrator!" -ForegroundColor Red
    exit
}

# Function to create or update registry keys
function Set-RegValue {
    param(
        [string]$Path,
        [string]$Name,
        [object]$Value,
        [Microsoft.Win32.RegistryValueKind]$Type = [Microsoft.Win32.RegistryValueKind]::String
    )

    $Path = $Path -replace '^HKCR:', 'Registry::HKEY_CLASSES_ROOT'
    $Path = $Path -replace '^HKLM:', 'Registry::HKEY_LOCAL_MACHINE'

    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }

    if (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue) {
        Set-ItemProperty -Path $Path -Name $Name -Value $Value
    } else {
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type | Out-Null
    }
}

Write-Host "Remapping Caps Lock to Escape..." -ForegroundColor Cyan
Set-RegValue "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" "Scancode Map" `
    ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x01,0x00,0x3A,0x00,0x00,0x00,0x00,0x00)) `
    ([Microsoft.Win32.RegistryValueKind]::Binary)

Write-Host "Setting up folder context menu handlers..." -ForegroundColor Cyan

# CMD in background
Set-RegValue "HKCR:\Directory\Background\shell\cmd" "(Default)" "@shell32.dll,-8506"
Set-RegValue "HKCR:\Directory\Background\shell\cmd" "Extended" ""
Set-RegValue "HKCR:\Directory\Background\shell\cmd" "HideBasedOnVelocityId" 0x639bc8 ([Microsoft.Win32.RegistryValueKind]::DWord)
Set-RegValue "HKCR:\Directory\Background\shell\cmd" "NoWorkingDirectory" ""
Set-RegValue "HKCR:\Directory\Background\shell\cmd\command" "(Default)" 'cmd.exe /s /k pushd "%V"'

# PowerShell in background
Set-RegValue "HKCR:\Directory\Background\shell\Powershell" "(Default)" "@shell32.dll,-8508"
Set-RegValue "HKCR:\Directory\Background\shell\Powershell" "Extended" ""
Set-RegValue "HKCR:\Directory\Background\shell\Powershell" "NoWorkingDirectory" ""
Set-RegValue "HKCR:\Directory\Background\shell\Powershell" "ShowBasedOnVelocityId" 0x639bc8 ([Microsoft.Win32.RegistryValueKind]::DWord)
Set-RegValue "HKCR:\Directory\Background\shell\Powershell\command" "(Default)" 'powershell.exe -noexit -command Set-Location -literalPath ''%V'''

# VSCode in background
$vscodeCmd = '"C:\Users\HIM\AppData\Local\Programs\Microsoft VS Code\Code.exe" "%V"'
Set-RegValue "HKCR:\Directory\Background\shell\VSCode" "(Default)" "Open w&ith Code"
Set-RegValue "HKCR:\Directory\Background\shell\VSCode\command" "(Default)" $vscodeCmd

# Windows Terminal
$wtCmd = "$env:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe -d `"%V`""
Set-RegValue "HKCR:\Directory\Background\shell\WindowsTerminalHere" "(Default)" "Open In Terminal"
Set-RegValue "HKCR:\Directory\Background\shell\WindowsTerminalHere\command" "(Default)" $wtCmd

Write-Host "Folder context menu entries updated successfully." -ForegroundColor Green

Write-Host "`n⚠️  You must restart your computer for the Caps Lock remap to take effect." -ForegroundColor Yellow
