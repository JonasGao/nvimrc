local ready, whichkey = pcall(require, "which-key")
if (not ready) then return end

vim.o.timeout = true
vim.o.timeoutlen = 500
whichkey.setup {
  plugins = {
    marks = true,
    registers = true,
    presets = {
      motions = true,
      windows = true,
      nav = true,
      text_objects = true,
    },
  },
  -- deprecated
  -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^call ", "^lua ", "^:", "^ " },
  show_help = true,
  show_keys = true,
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}
