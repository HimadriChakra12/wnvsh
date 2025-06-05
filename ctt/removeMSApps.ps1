# List of Appx packages to remove (supports wildcard *)
$appxPackages = @(
    "Microsoft.Microsoft3DViewer",
    "Microsoft.AppConnector",
    "Microsoft.BingFinance",
    "Microsoft.BingNews",
    "Microsoft.BingSports",
    "Microsoft.BingTranslator",
    "Microsoft.BingWeather",
    "Microsoft.BingFoodAndDrink",
    "Microsoft.BingHealthAndFitness",
    "Microsoft.BingTravel",
    "Microsoft.MinecraftUWP",
    "Microsoft.GamingServices",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.Messaging",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.NetworkSpeedTest",
    "Microsoft.News",
    "Microsoft.Office.Lens",
    "Microsoft.Office.Sway",
    "Microsoft.Office.OneNote",
    "Microsoft.OneConnect",
    "Microsoft.People",
    "Microsoft.Print3D",
    "Microsoft.SkypeApp",
    "Microsoft.Wallet",
    "Microsoft.Whiteboard",
    "Microsoft.WindowsAlarms",
    "microsoft.windowscommunicationsapps",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.WindowsMaps",
    "Microsoft.YourPhone",
    "Microsoft.WindowsSoundRecorder",
    "Microsoft.XboxApp",
    "Microsoft.ConnectivityStore",
    "Microsoft.ScreenSketch",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGameCallableUI",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.MixedReality.Portal",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "Microsoft.Getstarted",
    "Microsoft.MicrosoftOfficeHub",
    "*EclipseManager*",
    "*ActiproSoftwareLLC*",
    "*AdobeSystemsIncorporated.AdobePhotoshopExpress*",
    "*Duolingo-LearnLanguagesforFree*",
    "*PandoraMediaInc*",
    "*CandyCrush*",
    "*BubbleWitch3Saga*",
    "*Wunderlist*",
    "*Flipboard*",
    "*Twitter*",
    "*Facebook*",
    "*Royal Revolt*",
    "*Sway*",
    "*Speed Test*",
    "*Dolby*",
    "*Viber*",
    "*ACGMediaPlayer*",
    "*Netflix*",
    "*OneCalendar*",
    "*LinkedInforWindows*",
    "*HiddenCityMysteryofShadows*",
    "*Hulu*",
    "*HiddenCity*",
    "*AdobePhotoshopExpress*",
    "*HotspotShieldFreeVPN*",
    "*Microsoft.Advertising.Xaml*"
)

Write-Host "Starting removal of listed Appx packages..."

foreach ($pattern in $appxPackages) {
    # Get all installed packages matching the pattern
    $packages = Get-AppxPackage -AllUsers | Where-Object { $_.Name -like $pattern }
    foreach ($pkg in $packages) {
        try {
            Write-Host "Removing package: $($pkg.Name)"
            Remove-AppxPackage -Package $pkg.PackageFullName -ErrorAction SilentlyContinue
            # Also remove provisioned package for new users
            Remove-AppxProvisionedPackage -Online -PackageName $pkg.PackageName -ErrorAction SilentlyContinue
        } catch {
            Write-Warning "Failed to remove package $($pkg.Name): $_"
        }
    }
}

Write-Host "Finished removing listed Appx packages."

# --- Microsoft Teams Removal Section ---

Write-Host "Starting Microsoft Teams removal..."

$TeamsPath = Join-Path $env:LOCALAPPDATA "Microsoft\Teams"
$TeamsUpdateExePath = Join-Path $TeamsPath "Update.exe"

Write-Host "Stopping Teams process..."
Get-Process -Name "*teams*" -ErrorAction SilentlyContinue | Stop-Process -Force

Write-Host "Uninstalling Teams from $TeamsPath"
if (Test-Path $TeamsUpdateExePath) {
    $proc = Start-Process -FilePath $TeamsUpdateExePath -ArgumentList "-uninstall -s" -PassThru
    $proc.WaitForExit()
} else {
    Write-Warning "Teams Update.exe not found at $TeamsUpdateExePath"
}

Write-Host "Removing Teams AppxPackage for all users..."
Get-AppxPackage -AllUsers | Where-Object { $_.Name -like "*Teams*" } | ForEach-Object {
    try {
        Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
    } catch {
        Write-Warning "Failed to remove AppxPackage for Teams: $_"
    }
}

Write-Host "Deleting Teams directory..."
if (Test-Path $TeamsPath) {
    try {
        Remove-Item -Path $TeamsPath -Recurse -Force -ErrorAction SilentlyContinue
    } catch {
        Write-Warning "Failed to delete Teams directory: $_"
    }
}

Write-Host "Removing Teams uninstall registry entry..."
$uninstallStrings = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall |
    Get-ItemProperty | Where-Object { $_.DisplayName -like '*Teams*' } | Select-Object -ExpandProperty UninstallString -ErrorAction SilentlyContinue

foreach ($us in $uninstallStrings) {
    if ($us) {
        $usModified = $us.Replace('/I', '/uninstall ').Replace('  ', ' ') + ' /quiet'
        $exePathEnd = $usModified.IndexOf('.exe') + 4
        $FilePath = $usModified.Substring(0, $exePathEnd).Trim()
        $ProcessArgs = $usModified.Substring($exePathEnd).Trim()
        Write-Host "Uninstalling Teams via: $FilePath $ProcessArgs"
        try {
            $proc = Start-Process -FilePath $FilePath -ArgumentList $ProcessArgs -PassThru
            $proc.WaitForExit()
        } catch {
            Write-Warning "Failed to uninstall Teams via uninstall string: $_"
        }
    }
}

Write-Host "Microsoft Teams removal complete."

