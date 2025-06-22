$wingetpacks = @(
    @{ Name = "Firefox"; Command = { winget install Mozilla.firefox -h --accept-package-agreements --accept-source-agreements| out-null }}
    @{ Name = "Powershell"; Command = { winget install 9MZ1SNWT0N5D -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "gsudo"; Command = { winget install gsudo -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "Windows Terminal"; Command = { winget install 9N0DX20HK701 -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "GlazeWM"; Command = { winget install glazewm -h --accept-package-agreements --accept-source-agreements | out-null}},

    @{ Name = "Lite-Xl"; Command = { winget install --id=LiteXLTeam.LPM -e h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "Sumatra PDF"; Command = { winget install sumatrapdf -h --accept-package-agreements --accept-source-agreements| out-null }}
    @{ Name = "VLC"; Command = { winget install VideoLAN.VLC -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "qimgv"; Command = { winget install easymodo.qimgv -h --accept-package-agreements --accept-source-agreements| out-null }}
    @{ Name = "qBittorrent"; Command = { winget install qBittorrent.qBittorrent.Qt6 -h --accept-package-agreements --accept-source-agreements| out-null }}

    @{ Name = "DirectX"; Command = { winget install Microsoft.DirectX -h --accept-package-agreements --accept-source-agreements | out-null}},

    @{ Name = "Neovim"; Command = { winget install nvim -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "fzf"; Command = { winget install fzf -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "ripgrep"; Command = { winget install BurntSushi.ripgrep.MSVC -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "Git"; Command = { winget install git.git -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "GitHub CLI"; Command = { winget install github.cli -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "Lazygit"; Command = { winget install lazygit -h --accept-package-agreements --accept-source-agreements| out-null }}
    @{ Name = "FFmpeg"; Command = { winget install Gyan.FFmpeg -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "Eza"; Command = { winget install eza-community.eza -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "CATCLI"; Command = { winget install DataTools.CATCLI -h --accept-package-agreements --accept-source-agreements | out-null}},

    @{ Name = "Twinkletray"; Command = { winget install xanderfrangos.twinkletray -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "PowerToys"; Command = { winget install XP89DCGQ3K6VLD -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "EarTrumpet"; Command = { winget install 9NBLGGH516XP -h --accept-package-agreements --accept-source-agreements | out-null}},

    @{ Name = "Teracopy"; Command = { winget install CodeSector.TeraCopy -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "Legcord"; Command = { winget install smartfrigde.Legcord -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "LocalSend"; Command = { winget install LocalSend.LocalSend -h --accept-package-agreements --accept-source-agreements | out-null}},
    @{ Name = "FxSound"; Command = { winget install Fxsound.Fxsound -h --accept-package-agreements --accept-source-agreements| out-null }}

    @{ Name = "Java"; Command = { winget install Oracle.JavaRuntimeEnvironment -h --accept-package-agreements --accept-source-agreements | out-null}},
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
