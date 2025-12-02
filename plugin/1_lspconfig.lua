-- Configure diagnostic settings (global)
vim.diagnostic.config({
  update_in_insert = true,
  float = {
    source = "always"
  }
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- On attach function to configure LSP features and keymaps
local on_attach = function(client, bufnr)
  -- Set omnifunc for LSP completion
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Setup formatting on save if supported
  if client.server_capabilities.documentFormattingProvider then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end
    })
  end

  -- Helper function for mapping global keymaps
  local function map(mode, key, cmd, desc)
    local opts = { noremap = true, silent = true, desc = desc }
    vim.keymap.set(mode, key, cmd, opts)
  end

  -- Global diagnostic keymaps
  map('n', '<space>e', vim.diagnostic.open_float, "Show diagnostic float")
  map('n', '[d', vim.diagnostic.goto_prev, "Go to previous diagnostic")
  map('n', ']d', vim.diagnostic.goto_next, "Go to next diagnostic")
  map('n', '<space>q', vim.diagnostic.setloclist, "Add diagnostics to loclist")

  -- Helper function for mapping buffer-local keymaps
  local function buf_map(mode, key, cmd, desc)
    local opts = { noremap = true, silent = true, desc = desc, buffer = bufnr }
    vim.keymap.set(mode, key, cmd, opts)
  end

  -- Buffer-local LSP keymaps
  buf_map('n', '<space>b', vim.lsp.buf.definition, "Go to definition")
  buf_map('n', '<space><C-b>', vim.lsp.buf.declaration, "Go to declaration")
  buf_map('n', '<space>B', vim.lsp.buf.implementation, "Go to implementation")
  buf_map('n', '<space>D', vim.lsp.buf.type_definition, "Go to type definition")
  buf_map('n', '<space>r', vim.lsp.buf.references, "Show references")
  buf_map('n', '<space>f', function() vim.lsp.buf.format { async = true } end, "Format buffer")
  buf_map('n', '<space>c', vim.lsp.buf.code_action, "Show code actions")
  buf_map('n', '<C-k>', vim.lsp.buf.signature_help, "Show signature help")
  buf_map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  buf_map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  buf_map('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
  buf_map('n', '<space>R', vim.lsp.buf.rename, "Rename symbol")
  
  -- Add hover documentation (if not already set by lspsaga)
  buf_map('n', 'K', vim.lsp.buf.hover, "Show hover documentation")
end

-- PowerShell Editor Services configuration using Neovim 0.11+ vim.lsp.config
vim.lsp.config('powershell_es', {

  -- LSP capabilities
  capabilities = capabilities,
  
  -- On attach callback for setting up keymaps and features
  on_attach = on_attach,
})

-- Enable the PowerShell LSP server
vim.lsp.enable('powershell_es')
