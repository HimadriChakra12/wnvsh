# Install-JetBrainsMono-NerdFont.ps1
param(
    [string]$FontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip",
    [string]$FontName = "JetBrainsMono Nerd Font"
)

function Install-FontFromZip {
    param(
        [string]$Url,
        [string]$FontFolder = "$env:WINDIR\Fonts"
    )

    # Temp paths
    $tempZip = Join-Path $env:TEMP "JetBrainsMono.zip"
    $tempExtract = Join-Path $env:TEMP "JetBrainsMono"

    # Download
    Write-Host "Downloading $FontName..."
    Invoke-WebRequest -Uri $Url -OutFile $tempZip -UseBasicParsing

    # Extract
    Write-Host "Extracting..."
    Expand-Archive -LiteralPath $tempZip -DestinationPath $tempExtract -Force

    # Install all TTF/OTF fonts
    $fontFiles = Get-ChildItem -Path $tempExtract -Include *.ttf,*.otf -Recurse
    foreach ($file in $fontFiles) {
        Write-Host "Installing $($file.Name)..."
        $destination = Join-Path $FontFolder $file.Name
        Copy-Item -Path $file.FullName -Destination $destination -Force

        # Register the font
        $shellApp = New-Object -ComObject Shell.Application
        $fontsFolder = $shellApp.Namespace(0x14)  # Fonts folder
        $fontsFolder.CopyHere($file.FullName)
    }

    # Cleanup
    Remove-Item $tempZip -Force
    Remove-Item $tempExtract -Recurse -Force

    Write-Host "$FontName installed successfully!"
}

# Run
Install-FontFromZip -Url $FontUrl
