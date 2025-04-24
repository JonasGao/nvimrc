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

Install-Dependency