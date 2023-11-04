local ready, telescope = pcall(require, "telescope")
if (not ready) then return end


telescope.setup({
  defaults = {
    mappings = {
      n = {
      },
      i = {
        ["<C-h>"] = "which_key",
        ["<C-d>"] = require('telescope.actions').delete_buffer
      }
    }
  },
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
})
telescope.load_extension "file_browser"
telescope.load_extension "fzf"
telescope.load_extension "recent_files"

-- local builtin = require('telescope.builtin')
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
-- vim.keymap.set('n', '<leader>fv', builtin.git_files, opts)
-- vim.keymap.set('n', '<leader>fc', builtin.commands, opts)
-- vim.keymap.set('n', '<leader>fH', builtin.command_history, opts)
-- vim.keymap.set('n', '<leader>fr', builtin.registers, opts)
-- vim.keymap.set('n', '<leader>fC', builtin.colorscheme, opts)
-- vim.keymap.set('n', '<leader>fx', builtin.oldfiles, opts)
-- vim.keymap.set('n', '<leader>fe', [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]], opts)

local whichkey_ready, whichkey = pcall(require, "which-key")
if (not whichkey_ready) then return end

local builtin = require('telescope.builtin')
whichkey.register({
  f = {
    name = "Fuzzy Finder",
    f = { builtin.find_files, "find_files" },
    g = { builtin.live_grep, "live_grep" },
    b = { builtin.buffers, "buffers" },
    h = { builtin.help_tags, "help_tags" },
    v = { builtin.git_files, "git_files" },
    c = { builtin.commands, "commands" },
    H = { builtin.command_history, "command_history" },
    R = { builtin.registers, "registers" },
    C = { builtin.colorscheme, "colorscheme" },
    e = { builtin.oldfiles, "oldfiles" },
    r = { telescope.extensions.recent_files.pick, "recent_files" },
  }
}, { prefix = "<leader>" })
