param(
  [switch]$Packer,
  [switch]$Dependency,
  [switch]$BuildFzf,
  $HttpProxy
)

function Install-Packer
{
  $D = "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
  if (Test-Path $D)
  {
    return
  }
  git clone https://github.com/wbthomason/packer.nvim $D
}

function Install-Dependency
{
  if ($HttpProxy)
  {
    Write-Host "Config scoop using proxy: http://$HttpProxy"
    scoop config proxy $HttpProxy
  }
  try
  {
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
    if ($HttpProxy)
    {
      $HTTPS_PROXY = "http://$HttpProxy"
    }
    try
    {
      npm install -g tree-sitter-cli
    } finally
    {
      Remove-Variable HTTPS_PROXY
    }
    # or
    # cargo install tree-sitter-cli
    # install cargo please download https://win.rustup.rs/x86_64
    # linux or unix, use "curl https://sh.rustup.rs -sSf | sh"

    # For lsp
    scoop install lua-language-server
  } finally
  {
    if ($HttpProxy)
    {
      Write-Host "Remove scoop proxy"
      scoop config rm proxy
    }
  }
}

function Build-TelescopeFzfNative
{
  Set-Location "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\telescope-fzf-native.nvim\"
  cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build
}

if ($Packer)
{
  Install-Packer
}

if ($Dependency)
{
  Install-Dependency
}

if ($BuildFzf)
{
  Build-TelescopeFzfNative
}
