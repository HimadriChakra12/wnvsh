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

        [string]$ISO,
        [string]$OSType,
        [string]$Type = "headless"
    )

    switch ($Command.ToLower()) {

        "-t" {
            VBoxManage list ostypes
        }

        "-s"     { if ($VMName) { VBoxManage startvm "$VMName" --type=$Type } else { Write-Host "Missing VM name." } }
        "-S"      { if ($VMName) { VBoxManage controlvm "$VMName" acpipowerbutton } else { Write-Host "Missing VM name." } }
        "-o"  { if ($VMName) { VBoxManage controlvm "$VMName" poweroff } else { Write-Host "Missing VM name." } }
        "-l"      { VBoxManage list vms }
        "-i"      { if ($VMName) { VBoxManage showvminfo "$VMName" } else { Write-Host "Missing VM name." } }
        "-d"    { if ($VMName) { VBoxManage unregistervm "$VMName" --delete } else { Write-Host "Missing VM name." } }

        "-c" {
            if (-not ($VMName -and $ISO)) {
                Write-Host "Usage: vb create <VMName> <ISOPath> [OSType]"
                return
            }

            if (-not $OSType) {
                Write-Host "`nAvailable OS Types:`n"
                VBoxManage list ostypes | Select-String -Pattern "ID:|Description:" | ForEach-Object { $_.ToString() }
                $OSType = Read-Host "`nEnter the OS type ID (e.g., Ubuntu_64, Windows10_64)"
            }

            $vmsDir = "$env:USERPROFILE\VirtualBox VMs\$VMName"
            $vdiPath = "$vmsDir\$VMName.vdi"

            VBoxManage createvm --name "$VMName" --ostype "$OSType" --register
            VBoxManage modifyvm "$VMName" --memory 2048 --vram 16 --audio none --boot1 dvd --nic1 nat
            VBoxManage createhd --filename "$vdiPath" --size 20000
            VBoxManage storagectl "$VMName" --name "SATA Controller" --add sata --controller IntelAhci
            VBoxManage storageattach "$VMName" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$vdiPath"
            VBoxManage storageattach "$VMName" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$ISO"

            Write-Host "`nVM '$VMName' created with type '$OSType'. You can now run: vb start '$VMName'"
        }

        default {
            Write-Host "Usage:"
            Write-Host "  vb -l"
            Write-Host "  vb -s <VM> [-Type gui|headless]"
            Write-Host "  vb -S <VM>"
            Write-Host "  vb -o <VM>"
            Write-Host "  vb -i <VM>"
            Write-Host "  vb -d <VM>"
            Write-Host "  vb -c <VM> <ISO> [OSType]"
            Write-Host "  vb -t    # list available OS types"
        }
    }
}
'@

# Only add if not already present
if (-not (Get-Content $PROFILE | Select-String $marker)) {
    Add-Content -Path $PROFILE -Value $vbFunction
    Write-Host " vb function added to $PROFILE"
} else {
    Write-Host "vb function already present in $PROFILE"
}

Write-Host "Done! Restart PowerShell to use the 'vb' command."

