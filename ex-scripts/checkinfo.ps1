# Save as LaptopCheck.ps1
# Run in PowerShell with:  .\LaptopCheck.ps1

Write-Host "===== SECOND-HAND LAPTOP EXTRA CHECKS =====" -ForegroundColor Cyan

# CPU Info (systeminfo only shows name, not cores/threads)
Write-Host "`n[CPU Details]" -ForegroundColor Yellow
Get-CimInstance Win32_Processor | 
Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed

# RAM Sticks (systeminfo shows total only, not per stick)
Write-Host "`n[RAM Modules]" -ForegroundColor Yellow
Get-CimInstance Win32_PhysicalMemory | 
Select-Object Manufacturer, PartNumber, @{N="Capacity(GB)";E={[math]::Round($_.Capacity/1GB)}}, Speed

# Disk Info & Health
Write-Host "`n[Disk Health]" -ForegroundColor Yellow
Get-PhysicalDisk | Select-Object FriendlyName, MediaType, Size, HealthStatus, OperationalStatus

# Battery Report
Write-Host "`n[Battery Status]" -ForegroundColor Yellow
Get-CimInstance Win32_Battery | 
Select-Object Name, BatteryStatus, EstimatedChargeRemaining, EstimatedRunTime

# GPU Info
Write-Host "`n[Graphics Adapter]" -ForegroundColor Yellow
Get-CimInstance Win32_VideoController | Select-Object Name, DriverVersion, AdapterRAM

# Network Check
Write-Host "`n[Network Adapters]" -ForegroundColor Yellow
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, LinkSpeed

# Audio Devices
Write-Host "`n[Audio Devices]" -ForegroundColor Yellow
Get-CimInstance Win32_SoundDevice | Select-Object Name, Status

# Last Boot Time (helps spot crashes/restarts)
Write-Host "`n[Last Boot Time]" -ForegroundColor Yellow
Get-CimInstance Win32_OperatingSystem | 
Select-Object @{Name="LastBootUpTime";Expression={$_.LastBootUpTime}}

Write-Host "`n===== CHECK COMPLETE =====" -ForegroundColor Cyan
Write-Host "Tip: Run 'powercfg /batteryreport' for detailed battery history."