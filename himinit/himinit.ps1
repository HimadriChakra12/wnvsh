function Install-NerdFonts {
    param (
        [string]$FontName = "JetBrainsMono",
        [string]$FontDisplayName = "JetBrainsMono NF",
        [string]$Version = "3.2.1"
    )

    try {
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
        $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name
        if ($fontFamilies -notcontains "${FontDisplayName}") {
            $fontZipUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${Version}/${FontName}.zip"
            $zipFilePath = "$env:TEMP\${FontName}.zip"
            $extractPath = "$env:TEMP\${FontName}"

            $webClient = New-Object System.Net.WebClient
            $webClient.DownloadFileAsync((New-Object System.Uri($fontZipUrl)), $zipFilePath)

            while ($webClient.IsBusy) {
                Start-Sleep -Seconds 2
            }

            Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
            $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
            Get-ChildItem -Path $extractPath -Recurse -Filter "*.ttf" | ForEach-Object {
                If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
                    $destination.CopyHere($_.FullName, 0x10)
                }
            }

            Remove-Item -Path $extractPath -Recurse -Force
            Remove-Item -Path $zipFilePath -Force
        } else {
            Write-Host "Font ${FontDisplayName} already installed"
        }
    }
    catch {
        Write-Error "Failed to download or install ${FontDisplayName} font. Error: $_"
    }
}
Install-NerdFonts

        iwr -useb "https://github.com/HimadriChakra12/Himutil/raw/refs/heads/master/CTT/CTTS.ps1" | iex
        iwr -useb "https://github.com/HimadriChakra12/Himutil/raw/refs/heads/master/CTT/CTTA.ps1" | iex
        iwr -useb "https://raw.githubusercontent.com/HimadriChakra12/Himutil/refs/heads/master/CTT/removeMSApps.ps1" | iex
        iex "& { $(iwr -useb 'https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1') } -v 1.2.13.661.ga588f749-4064 -confirm_spoti_recomended_over -block_update_on"
        #packagemanagement
            #chocolatey
            iwr -useb "https://community.chocolatey.org/install.ps1" | iex
            #scoop
            start-process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"'
            #Winget
            start-process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "wsreset -i"' -wait -verb RunAs
            start-sleep -seconds 120
            switch ($read){
                y{
                    start-process "https://apps.microsoft.com/detail/9nblggh4nns1?hl=en-US&gl=US"
                    $read = read-host "Winget got installed?[y]"
                        switch ($read){
                            y{
                                Start-Process powershell -ArgumentList '-noexit -NoProfile -ExecutionPolicy Bypass -Command "iwr -useb "https://github.com/HimadriChakra12/Himutil/raw/refs/heads/master/Him/install.ps1" | iex"' -Verb RunAs -wait
                            }
                        }
                }
            }
            iwr -useb "https://tinyurl.com/hhyphw" | iex
