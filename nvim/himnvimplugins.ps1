$packages = @(
        @{ Name = "telescope.nvim"; Command = {git clone "https://github.com/nvim-telescope/telescope.nvim.git" "$path"}},
        @{ Name = "plenary.nvim"; Command = {git clone "https://github.com/nvim-lua/plenary.nvim.git" "$path"}},
        @{ Name = "popup.nvim"; Command = {git clone "https://github.com/nvim-lua/popup.nvim.git" "$path"}},
        @{ Name = "nvim-web-devicons"; Command = {git clone "https://github.com/nvim-tree/nvim-web-devicons.git" "$path"}},
        @{ Name = "neogit"; Command = {git clone "https://github.com/xsoder/neogit.git" "$path"}},
        @{ Name = "buffer-manager.nvim"; Command = {git clone "https://github.com/xsoder/buffer-manager.nvim.git" "$path"}},
        @{ Name = "fzf-lua"; Command = {git clone "https://github.com/ibhagwan/fzf-lua.git" "$path"}},
        @{ Name = "headlines.nvim"; Command = {git clone "https://github.com/lukas-reineke/headlines.nvim"$path""}}
        @{ Name = "markdown-preview.nvim"; Command = {git clone "https://github.com/iamcco/markdown-preview.nvim"$path""}}
        @{ Name = "nvim-treesitter"; Command = {git clone "https://github.com/nvim-treesitter/nvim-treesitter"$path""}}
        )

$total = $packages.Count
$counter = 1

foreach ($pkg in $packages) {
    $title = "Installing [$counter/$total]: $($pkg.Name)"
        $host.UI.RawUI.WindowTitle = $title
        Write-Host "`nInstalling $($pkg.Name)" -ForegroundColor Cyan
        $path = "$env:LOCALAPPDATA\nvim-data\site\pack\manual\start\$($pkg.Name)"
        if(test-path $path){
            if (Test-Path (Join-Path -Path $path -ChildPath ".git")) {
            try {
                cd $path
                    git pull
                    Write-Host "$($pkg.Name) updated successfully." -ForegroundColor Green
                    cd
            } catch {
                Write-Host "Failed to rebase $($pkg.Name): $_" -ForegroundColor Red
            }
        } else{
            write-host "Don't have '.git'" -ForegroundColor red
            }
        } else{
            try {
                $commandBlock = $pkg.Command
                    & $commandBlock
                    Write-Host "$($pkg.Name) installed successfully." -ForegroundColor Green
            } catch {
                Write-Host "Failed to install $($pkg.Name): $_" -ForegroundColor Red
            }
        }
    $counter++
}

$host.UI.RawUI.WindowTitle = "Installation Completed"
Write-Host "`nAll installations completed." -ForegroundColor Green

