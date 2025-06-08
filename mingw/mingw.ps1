# Set the download URL
$downloadUrl = "https://altushost-swe.dl.sourceforge.net/project/mingw/Installer/mingw-get-setup.exe?viasf=1"

# Set the output file path
$outputFile = "$env:USERPROFILE\Downloads\mingw-get-setup.exe"

# Download the file
try {
    Write-Host "Downloading MinGW from $downloadUrl..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $outputFile
    Write-Host "MinGW downloaded successfully to $outputFile"
} catch {
    Write-Error "Error downloading MinGW: $($_.Exception.Message)"
    return # Exit the script if download fails
}

# Run the installer and wait for it to close
try {
    Write-Host "Running MinGW installer... (Please complete the installation, then close the installer window)"
    Start-Process -FilePath $outputFile -Wait
    Write-Host "MinGW installer completed."
} catch {
    Write-Error "Error running MinGW installer: $($_.Exception.Message)"
    return # Exit if the installer fails to start
}

# Add mingw bin to path. (Example, you need to verify the actual install location)
$mingwInstallPath = "C:\MinGW\bin" # VERY IMPORTANT: Verify the install path after the installer completes.

try{
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$mingwInstallPath*"){
        [Environment]::SetEnvironmentVariable("Path", "$currentPath;$mingwInstallPath", "User")
        Write-Host "MinGW bin added to user PATH."
    } else {
        Write-Host "MinGW bin already in user PATH."
    }
} catch {
    Write-Error "Error adding mingw to path: $($_.Exception.Message)"
}

Write-Host "Please close and reopen any open powershell windows for the updated PATH variable to take effect."
