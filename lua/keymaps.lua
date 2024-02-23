-- Inspired by https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/keymaps.lua
local function map(mode, key, cmd, desc)
  local o = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, key, cmd, o)
end

map("n", "te", ":tabedit<cr>")
map("n", "<Space>a", "gg0vG$")
map("i", "<C-p>d", "<C-r>=system('date')<CR>")
map("n", "<space>l", ":bn<cr>", "Next Buffer")
map("n", "<space>h", ":bp<cr>", "Prev Buffer")

local wk = require("which-key")
wk.register({
  y = { "\"*y", "Yank" },
  p = { "\"*p", "Paste", mode = { "n", "v" } },
  x = { "<cmd>set paste!<cr>", "Set paste mode" },
  r = { ":%s/", "Replace" },
  i = {
    name = "+Insert",
    d = { "<cmd>r!date<cr>", "+Date" },
  },
  n = {
    name = "+Switch",
    n = { "<cmd>set nu! rnu!<cr>", "Switch line number" },
    w = { "<cmd>set wrap!<cr>", "Switch wrap mode" },
  },
  m = { ":set filetype=", "Set filetype" },
  S = { "<cmd>source $MYVIMRC<cr>", "Reload rcfile" },
  w = {
    name = "+Window",
    [","] = { "<C-w><", "" },
    ["."] = { "<C-w>>", "" },
  },
  s = {
    name = "+Split",
    s = { "<cmd>split<cr><C-w>w", "Split horizontal" },
    v = { "<cmd>vsplit<cr><C-w>w", "Split vertical" },
  },
  b = {
    name = "+Buffer",
    b = { "<cmd>ls<cr>", "List" },
    d = { "<cmd>bd<cr>", "Delete current" },
    h = { "<cmd>bp<cr>", "Prev buffer" },
    l = { "<cmd>bn<cr>", "Next buffer" },
    s = { "<cmd>w<cr>", "Save" },
  },
  z = {
    name = "+FlodMethod",
    z = { "<cmd>set nofoldenable<cr>", "Nofoldenable" },
    s = { "<cmd>set foldmethod=syntax<cr>", "Syntax" },
    i = { "<cmd>set foldmethod=indent<cr>", "Indent" },
    m = { "<cmd>set foldmethod=manual<cr>", "Manual" },
    k = { "<cmd>set foldmethod=marker<cr>", "Marker" },
    q = { "<cmd>set foldmethod<cr>", "Query current" }
  },
  q = {
    name = "+EasyMotion",
    s = { "<Plug>(easymotion-s2)", "2-Char Search" },
    t = { "<Plug>(easymotion-t2)", "2-Char Search (T)" },
    j = { "<Plug>(easymotion-j)", "J motion" },
    k = { "<Plug>(easymotion-k)", "K motion" }
  },
  B = {
    name = "+Browser",
    r = { "<cmd>bro ol<cr>", "Old files" },
  },
  ["1"] = { "<cmd>b1<cr>", "Buffer 1" },
  ["2"] = { "<cmd>b2<cr>", "Buffer 2" },
  ["3"] = { "<cmd>b3<cr>", "Buffer 3" },
  ["4"] = { "<cmd>b4<cr>", "Buffer 4" },
  ["5"] = { "<cmd>b5<cr>", "Buffer 5" },
  ["6"] = { "<cmd>b6<cr>", "Buffer 6" },
  ["7"] = { "<cmd>b7<cr>", "Buffer 7" },
  ["8"] = { "<cmd>b8<cr>", "Buffer 8" },
  ["9"] = { "<cmd>b9<cr>", "Buffer 9" },
}, { prefix = "<leader>" })
