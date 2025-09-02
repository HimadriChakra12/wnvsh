# Save this as LaptopCheck.ps1
# Run in PowerShell with:  .\LaptopCheck.ps1

Write-Host "===== SECOND-HAND LAPTOP CHECK REPORT =====" -ForegroundColor Cyan

# System Info
Write-Host "`n[System Info]" -ForegroundColor Yellow
Get-ComputerInfo | Select-Object CsManufacturer, CsModel, WindowsProductName, WindowsVersion, OsArchitecture, CsTotalPhysicalMemory

# CPU Info
Write-Host "`n[CPU Info]" -ForegroundColor Yellow
Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed

# RAM Info
Write-Host "`n[RAM Info]" -ForegroundColor Yellow
Get-CimInstance Win32_PhysicalMemory | 
Select-Object Manufacturer, PartNumber, @{N="Capacity(GB)";E={[math]::Round($_.Capacity/1GB)}}, Speed

# Disk Info & Health (SMART)
Write-Host "`n[Disk Info]" -ForegroundColor Yellow
Get-PhysicalDisk | Select-Object FriendlyName, MediaType, Size, HealthStatus, OperationalStatus

# Battery Report
Write-Host "`n[Battery Status]" -ForegroundColor Yellow
Get-CimInstance Win32_Battery | 
Select-Object Name, BatteryStatus, EstimatedChargeRemaining, EstimatedRunTime
powercfg /batteryreport

# GPU Info
Write-Host "`n[Graphics Adapter]" -ForegroundColor Yellow
Get-CimInstance Win32_VideoController | Select-Object Name, DriverVersion, AdapterRAM

# Network Check
Write-Host "`n[Network Adapters]" -ForegroundColor Yellow
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, LinkSpeed

# Audio Check
Write-Host "`n[Audio Devices]" -ForegroundColor Yellow
Get-CimInstance Win32_SoundDevice | Select-Object Name, Status

# Last Boot Time (shows if it reboots cleanly)
Write-Host "`n[Last Boot Time]" -ForegroundColor Yellow
Get-CimInstance Win32_OperatingSystem | 
Select-Object @{Name="LastBootUpTime";Expression={$_.LastBootUpTime}}

Write-Host "`n===== CHECK COMPLETE =====" 