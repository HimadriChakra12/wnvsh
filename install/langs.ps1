$wingetpacks = @(
    @{ Name = "Node.js"; Command = { winget install OpenJS.NodeJS -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "Java"; Command = { winget install Oracle.JavaRuntimeEnvironment -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "Rustup"; Command = { winget install Rustlang.Rustup -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "jq"; Command = { winget install jqlang.jq -h --accept-package-agreements --accept-source-agreements| out-null }}
    @{ Name = "Go"; Command = { winget install Golang.go -h --accept-package-agreements --accept-source-agreements| out-null }}
    @{ Name = "Python3"; Command = { winget install python3 -h --accept-package-agreements --accept-source-agreements| out-null }}
    @{ Name = "sqlite"; Command = { winget install sqlite.sqlite -h --accept-package-agreements --accept-source-agreements| out-null }}
)

$total = $wingetpacks.Count
$counter = 1

$counter = 1
foreach ($pkg in $wingetpacks) {
    $title = "Installing [$counter/$total]: $($pkg.Name) from Winget"
    $host.UI.RawUI.WindowTitle = $title
    Write-Host "`nInstalling $($pkg.Name)" -ForegroundColor Cyan
    try {
        & $pkg.Command
        Write-Host "$($pkg.Name) installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to install $($pkg.Name): $_" -ForegroundColor Red
    }
    $counter++
}
$host.UI.RawUI.WindowTitle = "Installation Completed $total packages"
start-sleep 2
