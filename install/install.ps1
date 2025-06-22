$wingetpacks = @(
    @{ Name = "Windows Terminal"; Command = { winget install 9N0DX20HK701 -h --accept-package-agreements --accept-source-agreements | out-null}},

    @{ Name = "Sumatra PDF"; Command = { winget install sumatrapdf -h --accept-package-agreements --accept-source-agreements| out-null }}

    @{ Name = "fzf"; Command = { winget install fzf -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "ripgrep"; Command = { winget install BurntSushi.ripgrep.MSVC -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "Lazygit"; Command = { winget install lazygit -h --accept-package-agreements --accept-source-agreements| out-null }}
    @{ Name = "FFmpeg"; Command = { winget install Gyan.FFmpeg -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "Eza"; Command = { winget install eza-community.eza -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "CATCLI"; Command = { winget install DataTools.CATCLI -h --accept-package-agreements --accept-source-agreements | out-null}},

    @{ Name = "EarTrumpet"; Command = { winget install 9NBLGGH516XP -h --accept-package-agreements --accept-source-agreements | out-null}},

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
