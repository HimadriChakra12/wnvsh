# Install-NerdFont.ps1
param(
    [string]$Name = "JetBrainsMono",
    [switch]$Confirm
)

# Helper function: download file
function Download-File {
    param(
        [string]$Url,
        [string]$OutFile
    )
    Invoke-WebRequest -Uri $Url -OutFile $OutFile -UseBasicParsing
}

# Main logic
try {
    $tempFile = Join-Path $env:TEMP "Install-NerdFont.ps1"
    $scriptUrl = "https://to.loredo.me/Install-NerdFont.ps1"  # replace with your main NerdFont installer if needed
    Write-Host "Downloading NerdFont installer..."
    Download-File -Url $scriptUrl -OutFile $tempFile

    Write-Host "Running NerdFont installer for $Name..."
    & $tempFile -Name $Name -Confirm:$false

    Write-Host "Cleaning up..."
    Remove-Item $tempFile -Force

    Write-Host "Done!"
} catch {
    Write-Error "Failed: $_"
}
