# Set path to temp directory
$tempPath = "$env:LOCALAPPDATA\Temp"

iwr -uri "https://github.com/HimadriChakra12/Himutil/releases/download/handle.exe/handle.exe" -OutFile "$env:TEMP/handle.exe" ; copy-item "$env:TEMP/handle.exe" "C:/Windows/System32/handle.exe"

# Path to Sysinternals handle tool
$handlePath = "handle"  # Replace with full path if needed

# Get locked file info
$lockedOutput = & $handlePath -u -accepteula $tempPath 2>$null

if ($lockedOutput) {
    Write-Host "Scanning for locked files..."
    foreach ($line in $lockedOutput) {
        if ($line -match "pid: (\d+)") {
            $pid = [int]$matches[1]
            try {
                $proc = Get-Process -Id $pid -ErrorAction Stop

                if ($proc.ProcessName -eq "powershell" -or $proc.ProcessName -eq "pwsh") {
                    Write-Host "Skipping locked file held by $($proc.ProcessName) (PID: $pid)"
                    continue
                }

                Write-Host "Killing process $($proc.ProcessName) (PID: $pid)..."
                Stop-Process -Id $pid -Force
            } catch {
                Write-Warning "Could not stop process with PID ${pid}: $_"
            }
        }
    }
} else {
    Write-Host "No locked files found by handle.exe."
}

Start-Sleep -Seconds 2

# Try to remove temp files
Write-Host "Attempting to clean temp directory..."
try {
    Remove-Item "$tempPath\*" -Recurse -Force -ErrorAction Stop
    Write-Host "Temp directory cleaned."
} catch {
    Write-Warning "Error during cleanup: $_"
}
