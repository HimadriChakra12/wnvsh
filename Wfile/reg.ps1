# Requires elevation
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Please run this script as Administrator!" -ForegroundColor Red
    exit
}

# Function to create registry keys
function Set-RegValue {
    param(
        [string]$Path,
        [string]$Name,
        [object]$Value,
        [Microsoft.Win32.RegistryValueKind]$Type = [Microsoft.Win32.RegistryValueKind]::String
    )

    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type
}

Write-Host "Remapping Caps Lock to Escape..." -ForegroundColor Cyan
Set-RegValue "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" "Scancode Map" `
    ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x01,0x00,0x3A,0x00,0x00,0x00,0x00,0x00)) `
    ([Microsoft.Win32.RegistryValueKind]::Binary)

Write-Host "Setting up folder context menu handlers..." -ForegroundColor Cyan

# CMD in background
Set-RegValue "HKCR:\Directory\Background\shell\cmd" "(default)" "@shell32.dll,-8506"
Set-RegValue "HKCR:\Directory\Background\shell\cmd" "Extended" ""
Set-RegValue "HKCR:\Directory\Background\shell\cmd" "HideBasedOnVelocityId" 0x639bc8 ([Microsoft.Win32.RegistryValueKind]::DWord)
Set-RegValue "HKCR:\Directory\Background\shell\cmd" "NoWorkingDirectory" ""
Set-RegValue "HKCR:\Directory\Background\shell\cmd\command" "(default)" 'cmd.exe /s /k pushd "%V"'

# PowerShell in background
Set-RegValue "HKCR:\Directory\Background\shell\Powershell" "(default)" "@shell32.dll,-8508"
Set-RegValue "HKCR:\Directory\Background\shell\Powershell" "Extended" ""
Set-RegValue "HKCR:\Directory\Background\shell\Powershell" "NoWorkingDirectory" ""
Set-RegValue "HKCR:\Directory\Background\shell\Powershell" "ShowBasedOnVelocityId" 0x639bc8 ([Microsoft.Win32.RegistryValueKind]::DWord)
Set-RegValue "HKCR:\Directory\Background\shell\Powershell\command" "(default)" "powershell.exe -noexit -command Set-Location -literalPath '%V'"

# VSCode in background
$vscodeCmd = '"C:\Users\HIM\AppData\Local\Programs\Microsoft VS Code\Code.exe" "%V"'
Set-RegValue "HKCR:\Directory\Background\shell\VSCode" "(default)" "Open w&ith Code"
Set-RegValue "HKCR:\Directory\Background\shell\VSCode\command" "(default)" $vscodeCmd

# Windows Terminal
$wtCmd = "$env:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe -d `"%V`""
Set-RegValue "HKCR:\Directory\Background\shell\WindowsTerminalHere" "(default)" "Open In Terminal"
Set-RegValue "HKCR:\Directory\Background\shell\WindowsTerminalHere\command" "(default)" $wtCmd

Write-Host "Folder context menu entries updated successfully." -ForegroundColor Green

Write-Host "`n⚠️ You must restart your computer for the Caps Lock remap to take effect." -ForegroundColor Yellow
