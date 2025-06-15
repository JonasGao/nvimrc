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

  Install-TreeSitter
}

function Install-TreeSitter {
  # 使用 GitHub API 获取最新发布版本
  $apiUrl = "https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest"
  $treeSitterDir = "$HOME/bin"
  $treeSitterExe = "$treeSitterDir/tree-sitter.exe"

  # 检查代理环境变量
  $proxy = $env:HTTPS_PROXY
  if (-not $proxy) { $proxy = $env:HTTP_PROXY }

  if (-not (Test-Path $treeSitterExe)) {
    Write-Host "正在从 GitHub 获取最新发布版本信息..."
    try {
      $headers = @{
        "Accept" = "application/vnd.github.v3+json"
        "User-Agent" = "PowerShell"
      }
      if ($proxy) {
        $releaseInfo = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Proxy $proxy
      } else {
        $releaseInfo = Invoke-RestMethod -Uri $apiUrl -Headers $headers
      }
      
      # 查找 Windows x64 版本的资源
      $treeSitterAsset = $releaseInfo.assets | Where-Object { $_.name -like "*tree-sitter-windows-x64*" }
      if (-not $treeSitterAsset) {
        throw "未找到 Windows x64 版本的 tree-sitter"
      }
      $treeSitterUrl = $treeSitterAsset.browser_download_url
      
      Write-Host "正在下载 tree-sitter-cli (版本: $($releaseInfo.tag_name))..."
      if (-not (Test-Path $treeSitterDir)) {
        New-Item -ItemType Directory -Path $treeSitterDir | Out-Null
      }
      $gzPath = "$treeSitterDir/tree-sitter.gz"
      if ($proxy) {
        Invoke-WebRequest -Uri $treeSitterUrl -OutFile $gzPath -Proxy $proxy
      } else {
        Invoke-WebRequest -Uri $treeSitterUrl -OutFile $gzPath
      }
      Write-Host "正在解压 tree-sitter-cli ..."
      
      # 使用 gzip 解压
      $gzipStream = New-Object System.IO.Compression.GZipStream(
        [System.IO.File]::OpenRead($gzPath),
        [System.IO.Compression.CompressionMode]::Decompress
      )
      $outputFile = [System.IO.File]::Create($treeSitterExe)
      $gzipStream.CopyTo($outputFile)
      $outputFile.Close()
      $gzipStream.Close()
      
      Remove-Item $gzPath
      Write-Host "tree-sitter-cli 已下载并解压到 $treeSitterDir"
      # 自动将 $treeSitterDir 添加到账户 PATH 环境变量
      $userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
      if ($userPath -notlike "*$treeSitterDir*") {
        [Environment]::SetEnvironmentVariable("PATH", "$userPath;$treeSitterDir", "User")
        Write-Host "$treeSitterDir 已添加到账户 PATH 环境变量。请重新打开终端以生效。"
      }
    } catch {
      Write-Host "获取或下载 tree-sitter 失败: $_"
      return
    }
  } else {
    Write-Host "tree-sitter-cli 已安装。"
  }
}

Install-Dependency