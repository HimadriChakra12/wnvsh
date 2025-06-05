Write-host "Disabling pwsh7 telemetry"
[Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', '1', 'Machine')

Write-host "Setting HomeGroupProvider & HomeGroupListener service to Manual"
Set-Service -Name 'HomeGroupListener' -StartupType Manual -ErrorAction SilentlyContinue
Set-Service -Name 'HomeGroupProvider' -StartupType Manual -ErrorAction SilentlyContinue

write-host "Deleting Temp Files..."
Get-ChildItem -Path "C:\Windows\Temp" *.* -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path $env:TEMP *.* -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

iwr -useb "https://github.com/HimadriChakra12/Himutil/raw/refs/heads/master/CTT/temp.ps1" | iex

function System-Cleaner{
    cleanmgr.exe /d C: /VERYLOWDISK
    Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
}
Write-host "System Cleaner......"
System-Cleaner

function System-restore{
        try {
            # Try getting restore points to check if System Restore is enabled
            Enable-ComputerRestore -Drive "$env:SystemDrive"
        } catch {
            Write-Host "An error occurred while enabling System Restore: $_"
        } 
    }
Write-host "Creating Restore Point"
System-restore

function verbose-logon{
        $value = 1
        $Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
        Set-ItemProperty -Path $Path -Name VerboseStatus -Value $value -force
}
Write-Host "Enabling Verbose Logon Messages"
verbose-logon

function nonsticky-keys{
    $value = 510
        $Path = "HKCU:\Control Panel\Accessibility\StickyKeys"
        Set-ItemProperty -Path $Path -Name Flags -Value $value
}
Write-Host "Enabling Sticky Keys On startup"
nonsticky-keys

function unhidden-files{
    $value = 1
        $Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        Set-ItemProperty -Path $Path -Name Hidden -Value $value
}
Write-Host "Enabling Show Hidden Files"
unhidden-files

function file-extension {
    $value = 0
        $Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        Set-ItemProperty -Path $Path -Name HideFileExt -Value $value
}
Write-Host "Showing file extentions"
file-extension

function detail-bsod{
    $value = 1
        $Path = "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl"
        Set-ItemProperty -Path $Path -Name DisplayParameters -Value $value
}
Write-Host "Enabling Detailed BSoD"
detail-bsod

function startup-numlock{
    $value = 2
        New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS
        $HKUPath = "HKU:\.Default\Control Panel\Keyboard"
        $HKCUPath = "HKCU:\Control Panel\Keyboard"
        Set-ItemProperty -Path $HKUPath -Name InitialKeyboardIndicators -Value $value
        Set-ItemProperty -Path $HKCUPath -Name InitialKeyboardIndicators -Value $value
}
Write-Host "Enabling Numlock on startup"
startup-numlock 

function activity-unfeed{
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0 -Type DWord -ErrorAction SilentlyContinue -force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0 -Type DWord -ErrorAction SilentlyContinue -force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value 0 -Type DWord -ErrorAction SilentlyContinue -force
}
Write-host "Disabling Activity History..."
activity-unfeed

function g-dvr{
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" -Name "value" -Value 0 -Type DWord -ErrorAction SilentlyContinue -force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue -force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "GameDVR_Enabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue -force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "GameDVR_FSEBehavior" -Value 2 -Type DWord -ErrorAction SilentlyContinue -force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1 -Type DWord -ErrorAction SilentlyContinue -force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "GameDVR_EFSEFeatureFlags" -Value 0 -Type DWord -ErrorAction SilentlyContinue -force
}
write-host "Disabling GameDVR..."
g-dvr

function no-consumer{
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord -ErrorAction SilentlyContinue -force
}
Write-host "Disabling consumer features..."
no-consumer

function no-location{
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -Type String -ErrorAction SilentlyContinue -force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "SensorPermissionState" -Value 0 -Type DWord -ErrorAction SilentlyContinue -force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Status" -Value 0 -Type DWord -ErrorAction SilentlyContinue -force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" -Name "AutoUpdateEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue -force
}
Write-host "Disabling location and privacy permissions..."
no-location

function ip-624{
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents" -Value 32 -Type DWord -ErrorAction SilentlyContinue -force
}
ip-624

function no-stsense{
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Value 0 -Type Dword -Force
}
Write-host "Disabling storage sense..."
no-stsense

function no-hotspotreporting{
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Value 0 -Type DWord -force
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Value 0 -Type DWord -force
}
no-hotspotreporting

function Man-serve{
    iwr -useb "https://github.com/HimadriChakra12/Himutil/raw/refs/heads/master/CTT/manualserviceset.ps1" | iex
}
Man-serve

function dis-telemetry{
    iwr -useb "https://github.com/HimadriChakra12/Himutil/raw/refs/heads/master/CTT/disTelemetry.ps1" | iex
}
dis-telemetry

