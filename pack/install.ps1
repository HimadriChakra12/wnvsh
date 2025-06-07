    Write-host "Installing PSReadLine" -ForegroundColor cyan
        Install-Module -Name PowerShellGet -Force
        Install-Module PSReadLine -AllowPrerelease -Force
        Install-Module PSReadLine
$wingetpacks = @(
    #@{ Name = "Edge WebView2"; Command = { winget install Microsoft.EdgeWebView2Runtime -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Firefox"; Command = { winget install Mozilla.firefox -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "DirectX"; Command = { winget install Microsoft.DirectX -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "gsudo"; Command = { winget install gsudo -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Powershell"; Command = { winget install 9MZ1SNWT0N5D -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Windows Terminal"; Command = { winget install 9N0DX20HK701 -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "VSCode"; Command = { winget install vscode -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "VLC"; Command = { winget install VideoLAN.VLC -h --accept-package-agreements --accept-source-agreements }},
    #@{ Name = "Oh-My-Posh"; Command = { winget install JanDeDobbeleer.OhMyPosh -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "fzf"; Command = { winget install fzf -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Neovim"; Command = { winget install nvim -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "ripgrep"; Command = { winget install BurntSushi.ripgrep.MSVC -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Aria2"; Command = { winget install Aria2 -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Twinkletray"; Command = { winget install xanderfrangos.twinkletray -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Raindrop.io"; Command = { winget install RustemMussabekov.Raindrop -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "ModernFlyouts"; Command = { winget install ModernFlyouts.ModernFlyouts -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "NanaZip"; Command = { winget install M2team.NanaZip -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "FFmpeg"; Command = { winget install Gyan.FFmpeg -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Node.js"; Command = { winget install OpenJS.NodeJS -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "PowerToys"; Command = { winget install XP89DCGQ3K6VLD -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "EarTrumpet"; Command = { winget install 9NBLGGH516XP -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Whatsapp"; Command = { winget install 9NKSQGP7F2NH -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Java"; Command = { winget install Oracle.JavaRuntimeEnvironment -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Teracopy"; Command = { winget install CodeSector.TeraCopy -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "ShareX"; Command = { winget install sharex.Sharex -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "GlazeWM"; Command = { winget install glazewm -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Git"; Command = { winget install git.git -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "GitHub CLI"; Command = { winget install github.cli -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Steam"; Command = { winget install Valve.Steam -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Anki"; Command = { winget install Anki.Anki -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Fastfetch"; Command = { winget install Fastfetch-cli.Fastfetch -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Rustup"; Command = { winget install Rustlang.Rustup -h --accept-package-agreements --accept-source-agreements }},
    #@{ Name = "Typioca"; Command = { winget install bloznelis.typioca -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Eza"; Command = { winget install eza-community.eza -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "TL;DR"; Command = { winget install tldr-pages.tlrc -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "CATCLI"; Command = { winget install DataTools.CATCLI -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Legcord"; Command = { winget install smartfrigde.Legcord -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Hamachi"; Command = { winget install LogMeIn.Hamachi -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "LocalSend"; Command = { winget install LocalSend.LocalSend -h --accept-package-agreements --accept-source-agreements }},
    @{ Name = "Warp"; Command = { winget install Cloudflare.Warp -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "qimgv"; Command = { winget install easymodo.qimgv -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "FxSound"; Command = { winget install Fxsound.Fxsound -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "gPodder"; Command = { winget install gpodder.gpodder -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "7+ Taskbar Tweaker"; Command = { winget install RamenSoftware.7+TaskbarTweaker -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "qBittorrent"; Command = { winget install qBittorrent.qBittorrent.Qt6 -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "OBS Studio"; Command = { winget install OBSProject.OBSStudio -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "jq"; Command = { winget install jqlang.jq -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "sqlite"; Command = { winget install sqlite.sqlite -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "Sumatra PDF"; Command = { winget install sumatrapdf -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "Lazygit"; Command = { winget install lazygit -h --accept-package-agreements --accept-source-agreements }}
    @{ Name = "Terabox"; Command = { winget install baidu.terabox -h --accept-package-agreements --accept-source-agreements }}
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
