# Ensure profile exists
if (-not (Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
    Write-Host "Created profile: $PROFILE"
}

# Add VirtualBox path if not already in PATH
$vbPath = "C:\Program Files\Oracle\VirtualBox"
$envPath = [Environment]::GetEnvironmentVariable("Path", "User")
if (-not ($envPath.Split(';') -contains $vbPath)) {
    [Environment]::SetEnvironmentVariable("Path", "$envPath;$vbPath", "User")
    Write-Host "Added VirtualBox to user PATH"
}

# Define vb function (idempotently add to profile)
$marker = "# >>> VB FUNCTION START <<<"
$vbFunction = @'
# >>> VB FUNCTION START <<<
function vb {
    param(
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$Command,
        [Parameter(Position = 1)]
        [string]$VMName,
        [string]$Type = "headless"
    )
    switch ($Command.ToLower()) {
        "start"     { if ($VMName) { VBoxManage startvm "$VMName" --type=$Type } else { Write-Host "Missing VM name." } }
        "stop"      { if ($VMName) { VBoxManage controlvm "$VMName" acpipowerbutton } else { Write-Host "Missing VM name." } }
        "poweroff"  { if ($VMName) { VBoxManage controlvm "$VMName" poweroff } else { Write-Host "Missing VM name." } }
        "list"      { VBoxManage list vms }
        "info"      { if ($VMName) { VBoxManage showvminfo "$VMName" } else { Write-Host "Missing VM name." } }
        "delete"    { if ($VMName) { VBoxManage unregistervm "$VMName" --delete } else { Write-Host "Missing VM name." } }
        default     {
            Write-Host "Usage:"
            Write-Host "  vb list"
            Write-Host "  vb start <VM> [-Type gui|headless]"
            Write-Host "  vb stop <VM>"
            Write-Host "  vb poweroff <VM>"
            Write-Host "  vb info <VM>"
            Write-Host "  vb delete <VM>"
        }
    }
}
# >>> VB FUNCTION END <<<
'@

# Only add if not already present
if (-not (Get-Content $PROFILE | Select-String $marker)) {
    Add-Content -Path $PROFILE -Value $vbFunction
    Write-Host "✔ vb function added to $PROFILE"
} else {
    Write-Host "vb function already present in $PROFILE"
}

Write-Host "Done! Restart PowerShell to use the 'vb' command."

