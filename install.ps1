function Install-Dependency
{
  # 检查 scoop 是否已安装
  if (-not (Get-Command scoop -ErrorAction SilentlyContinue))
  {
    Write-Host "未找到 scoop，正在安装 scoop..."
    try {
      Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
      Invoke-RestMethod get.scoop.sh | Invoke-Expression
      Write-Host "scoop 安装完成。"
    } catch {
      Write-Host "scoop 安装失败，请手动安装 scoop。"
      return
    }
  } else {
    Write-Host "scoop 已安装。"
  }

  # 需要安装的软件列表
  $apps = @("cmake", "bat", "ripgrep", "fd", "gcc")
  foreach ($app in $apps) {
    if (-not (scoop list $app | Select-String $app)) {
      Write-Host "正在安装 $app ..."
      scoop install $app
    } else {
      Write-Host "$app 已安装。"
    }
  }

  # 检查 nodejs 和 npm
  if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "未找到 npm，正在安装 nodejs-lts ..."
    scoop install nodejs-lts
  } else {
    Write-Host "npm 已安装。"
  }

  # 安装 tree-sitter-cli（npm 方式）
  if (-not (Get-Command tree-sitter -ErrorAction SilentlyContinue)) {
    Write-Host "正在通过 npm 安装 tree-sitter-cli ..."
    npm install -g tree-sitter-cli
  } else {
    Write-Host "tree-sitter-cli 已安装。"
  }

  # cargo 安装 tree-sitter-cli（可选）
  # if (-not (Get-Command cargo -ErrorAction SilentlyContinue)) {
  #   Write-Host "请手动安装 Rust/cargo: https://win.rustup.rs/x86_64"
  # } else {
  #   if (-not (Get-Command tree-sitter -ErrorAction SilentlyContinue)) {
  #     cargo install tree-sitter-cli
  #   }
  # }
}

Install-Dependency