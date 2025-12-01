local mason_ready, mason = pcall(require, 'mason')
if (not mason_ready) then return end

local mason_lspconfig_ready, mason_lspconfig = pcall(require, 'mason-lspconfig')
if (not mason_lspconfig_ready) then return end

local prefix = os.getenv("GH_RPOXY") or vim.g.gh_proxy or ""
local url_template = prefix .. "https://github.com/%s/releases/download/%s/%s"
mason.setup({
  github = {
    download_url_template = url_template
  }
})

mason_lspconfig.setup({
  ensure_installed = {
    "powershell_es",
  },
  automatic_installation = true,
})
