# nvimrc
My Neovim rcfiles

## Installation

### Windows - Powershell

Install neovim first:

```powershell
scoop bucket add main
scoop install neovim
```

Install rcfiles.

```powershell
git clone https://github.com/JonasGao/nvimrc.git "$env:LOCALAPPDATA\nvim"
cd "$env:LOCALAPPDATA\nvim"
.\install.ps1
```

Startup neovim, run `PackerInstall`.
After install vc++ build tools ( or visual studio, containe vc++ build tools ). run `.\install.ps1 -BuildFzf` in "Developer Powershell for VS 20XX" build 'telescope navtive fzf'.

### Linux

```shell
git clone https://github.com/JonasGao/nvimrc.git $HOME/.config/nvim
```
