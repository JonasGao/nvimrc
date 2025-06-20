local lspconfig = require 'lspconfig'
local mason = require("mason-lspconfig")

require('vim.lsp.protocol')

vim.diagnostic.config({
  update_in_insert = true,
  float = {
    source = "always"
  }
})

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lsp Setup attact
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- formatting
  -- this will be update reference project 'lspconfig'
  if client.server_capabilities.documentFormattingProvider then
    local api = vim.api
    local augroup = api.nvim_create_augroup("LspFormatting", {})
    api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end
    })
    -- api.nvim_command [[augroup Format]]
    -- api.nvim_command [[autocmd! * <buffer>]]
    -- api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    -- api.nvim_command [[augroup END]]
  end

  local function map(mode, key, cmd, desc)
    local o = { noremap = true, silent = true, desc = desc }
    vim.keymap.set(mode, key, cmd, o)
  end

  map('n', '<space>e', vim.diagnostic.open_float, "diagnostic.open_float")
  map('n', '[d', vim.diagnostic.goto_prev, "Prev Problom")
  map('n', ']d', vim.diagnostic.goto_next, "Next Problom")
  map('n', '<space>q', vim.diagnostic.setloclist, "diagnostic.setloclist")

  local function buf_map(mode, key, cmd, desc)
    local o = { noremap = true, silent = true, desc = desc, buffer = bufnr }
    vim.keymap.set(mode, key, cmd, o)
  end

  buf_map('n', '<space>b', vim.lsp.buf.definition, "Goto Definition")
  buf_map('n', '<space><C-b>', vim.lsp.buf.declaration, "Goto Declaration")
  buf_map('n', '<space>B', vim.lsp.buf.implementation, "Goto Implementation")
  buf_map('n', '<space>D', vim.lsp.buf.type_definition, "Goto Type Definition")
  buf_map('n', '<space>r', vim.lsp.buf.references, "References")
  buf_map('n', '<space>f', function() vim.lsp.buf.format { async = true } end, "Format")
  buf_map('n', '<space>c', vim.lsp.buf.code_action, "Code action")

  -- Instead by lspsaga
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover)
  buf_map('n', '<C-k>', vim.lsp.buf.signature_help)
  buf_map('n', '<space>wa', vim.lsp.buf.add_workspace_folder)
  buf_map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder)
  buf_map('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end)
  buf_map('n', '<space>R', vim.lsp.buf.rename)
end

-- mason.setup_handlers {
--   -- The first entry (without a key) will be the default handler
--   -- and will be called for each installed server that doesn't have
--   -- a dedicated handler.
--   function(server_name) -- default handler (optional)
--     lspconfig[server_name].setup {
--       on_attach = on_attach,
--       flags = lsp_flags,
--       capabilities = capabilities,
--     }
--   end,
--   -- Next, you can provide a dedicated handler for specific servers.
--   -- For example, a handler override for the `rust_analyzer`:
--   ["rust_analyzer"] = function()
--     require("rust-tools").setup {}
--   end,
--   ["lua_ls"] = function()
--     lspconfig.lua_ls.setup {
--       on_attach = on_attach,
--       flags = lsp_flags,
--       capabilities = capabilities,
--       settings = {
--         Lua = {
--           runtime = {
--             -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--             version = 'LuaJIT',
--           },
--           diagnostics = {
--             -- Get the language server to recognize the `vim` global
--             globals = { 'vim' },
--           },
--           workspace = {
--             -- Make the server aware of Neovim runtime files
--             library = vim.api.nvim_get_runtime_file("", true),
--             checkThirdParty = false
--           },
--           -- Do not send telemetry data containing a randomized but unique identifier
--           telemetry = {
--             enable = false,
--           },
--         },
--       },
--     }
--   end,
--   ["yamlls"] = function()
--     lspconfig.yamlls.setup {
--       on_attach = function(client, bufnr)
--         client.server_capabilities.documentFormattingProvider = true
--         on_attach(client, bufnr)
--       end,
--       flags = lsp_flags,
--       capabilities = capabilities,
--       settings = {
--         yaml = {
--           format = {
--             enable = true
--           },
--           schemaStore = {
--             enable = true
--           }
--         }
--       }
--     }
--   end,
-- }
