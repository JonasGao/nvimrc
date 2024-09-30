local noice_ready, noice = pcall(require, 'noice')
if (not noice_ready) then return end

noice.setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
})

local notify_ready, notify = pcall(require, 'notify')
if (not notify_ready) then
  vim.notify("Not loaded notify plugin", vim.log.levels.ERROR)
  return
end

notify.setup({
  background_colour = "#000000",
  fps = 60,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 50,
  render = "default",
  stages = "fade_in_slide_out",
  time_formats = {
    notification = "%T",
    notification_history = "%FT%T"
  },
  timeout = 2000,
  top_down = true
})

local wr, wk = pcall(require, "which-key")
if (not wr) then return end

wk.add({
  { "<leader>t",  group = "+Notification" },
  { "<leader>tn", notify.dismiss,         desc = "Dismiss" },
})

local tr, ts = pcall(require, "telescope")
if (not tr) then return end

wk.add({
  { "<leader>th", ts.extensions.notify.notify, desc = "History" },
})
