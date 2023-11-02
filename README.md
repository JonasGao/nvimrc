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
git clone git@github.com:JonasGao/nvimrc.git "$env:LOCALAPPDATA\nvim"
cd "$env:LOCALAPPDATA\nvim"
.\install.ps1
```

Startup neovim, run `PackerInstall`.
After install vc++ build tools ( or visual studio, containe vc++ build tools ). run `.\install.ps1 -BuildFzf` build 'telescope navtive fzf'.



