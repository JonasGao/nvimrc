local mason_ready, mason = pcall(require, 'mason')
if (not mason_ready) then return end

local mason_lspconfig_ready, mason_lspconfig = pcall(require, 'mason-lspconfig')
if (not mason_lspconfig_ready) then return end

mason.setup()
mason_lspconfig.setup()
