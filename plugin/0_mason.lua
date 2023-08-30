local ready, mason = pcall(require, 'mason')
if (not ready) then return end

local ready, mason_lspconfig = pcall(require, 'mason-lspconfig')
if (not ready) then return end

mason.setup()
mason_lspconfig.setup()
