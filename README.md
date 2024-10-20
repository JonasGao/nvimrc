# nvimrc
My Neovim rcfiles

## Installation

### Windows - Powershell

Install neovim first:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop bucket add main
scoop install neovim
```

Or without scoope

```powershell
$v = curl -L -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/neovim/neovim/tags?per_page=1 | ConvertFrom-Json | Select -ExpandProperty name
curl -Lo nvim-win64.zip "https://github.com/neovim/neovim/releases/download/$v/nvim-win64.zip"
```

Install rcfiles.

```powershell
git clone https://github.com/JonasGao/nvimrc.git "$env:LOCALAPPDATA\nvim"
# git clone git@github.com:JonasGao/nvimrc.git "$env:LOCALAPPDATA\nvim"
cd "$env:LOCALAPPDATA\nvim"
.\install.ps1
```

Startup neovim, run `PackerInstall`.
After install vc++ build tools ( or visual studio, containe vc++ build tools ). run `.\install.ps1 -BuildFzf` in "Developer Powershell for VS 20XX" build 'telescope navtive fzf'.

### Linux

```shell
git clone https://github.com/JonasGao/nvimrc.git $HOME/.config/nvim
# git clone git@github.com:JonasGao/nvimrc.git $HOME/.config/nvim
cd $HOME/.config/nvim
./install.sh -p
```

If version lower. Install neovim in ubuntu

```shell
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
```
