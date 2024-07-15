-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local tree = require("nvim-tree")
local api = require("nvim-tree.api")

local function opts(desc)
  return { desc = desc, noremap = true, silent = true, nowait = true }
end

vim.keymap.set('n', '<leader>fp', api.tree.toggle, opts 'Toggle file explorer')

tree.setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    -- width = 30,
    adaptive_size = true
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- Pewview plugin
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local preview = require("nvim-tree-preview")

    vim.keymap.set("n", "P", preview.watch, opts 'Preview (Watch)')
    vim.keymap.set("n", "<Esc>", preview.unwatch, opts 'Close Preview')

    vim.keymap.set('n', '<Tab>', function()
      local ok, node = pcall(api.tree.get_node_under_cursor)
      if ok and node then
        if node.type == 'directory' then
          api.node.open.edit()
        else
          preview.node(node, { toggle_focus = true })
        end
      end
    end, opts 'Preview')
  end,
})
