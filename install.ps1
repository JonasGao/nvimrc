param(
  [switch]$BuildFzf
)

function Install-Packer
{
  $D = "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
  if (Test-Path $D)
  {
    Write-Output "'Packer' is already exists"
    return
  }
  git clone https://github.com/wbthomason/packer.nvim $D
  Write-Output "'Packer' was cloned successfully"
}

function Install-Dependency
{
  if (-not (Get-Command scoop))
  {
    Write-Host "Not found command scoop. Will install scoop."
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
  }
  # For telescope-fzf-native
  scoop install cmake
  # for telescope preview
  scoop install bat
  # for fuzzy finder and live-grep (like telescope and fzf ...)
  scoop install ripgrep
  scoop install fd

  # For treesitter
  scoop install gcc
  # install tree-sitter-cli
  try {
    Get-Command npm
  } catch 
  {
    scoop install nodejs-lts
  }
  npm install -g tree-sitter-cli
  # or
  # cargo install tree-sitter-cli
  # install cargo please download https://win.rustup.rs/x86_64
  # linux or unix, use "curl https://sh.rustup.rs -sSf | sh"
}

function Build-TelescopeFzfNative
{

  Push-Location "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\telescope-fzf-native.nvim\"
  try {
    cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build
  } finally
  {
    Pop-Location
  }
}

if ($BuildFzf)
{
  Build-TelescopeFzfNative
  return
}

Install-Packer
Install-Dependency
