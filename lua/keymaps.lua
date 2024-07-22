-- Inspired by https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/keymaps.lua
local function map(mode, key, cmd, desc)
  local o = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, key, cmd, o)
end

map("n", "te", ":tabedit<cr>")
map("i", "<C-p>d", "<C-r>=system('date')<CR>")

local wk = require("which-key")
wk.add( {
    { "<leader>1", "<cmd>b1<cr>", desc = "Buffer 1" },
    { "<leader>2", "<cmd>b2<cr>", desc = "Buffer 2" },
    { "<leader>3", "<cmd>b3<cr>", desc = "Buffer 3" },
    { "<leader>4", "<cmd>b4<cr>", desc = "Buffer 4" },
    { "<leader>5", "<cmd>b5<cr>", desc = "Buffer 5" },
    { "<leader>6", "<cmd>b6<cr>", desc = "Buffer 6" },
    { "<leader>7", "<cmd>b7<cr>", desc = "Buffer 7" },
    { "<leader>8", "<cmd>b8<cr>", desc = "Buffer 8" },
    { "<leader>9", "<cmd>b9<cr>", desc = "Buffer 9" },
    { "<leader>a", "gg0vG$", desc = "Select all" },
    { "<leader>B", group = "Browser" },
    { "<leader>Br", "<cmd>bro ol<cr>", desc = "Old files" },
    { "<leader>S", "<cmd>source $MYVIMRC<cr>", desc = "Reload rcfile" },
    { "<leader>b", group = "Buffer" },
    { "<leader>bb", "<cmd>ls<cr>", desc = "List" },
    { "<leader>bd", "<cmd>bd<cr>", desc = "Delete current" },
    { "<leader>bh", "<cmd>bp<cr>", desc = "Prev buffer" },
    { "<leader>bl", "<cmd>bn<cr>", desc = "Next buffer" },
    { "<leader>bs", "<cmd>w<cr>", desc = "Save" },
    { "<leader>i", group = "Insert" },
    { "<leader>id", "<cmd>r!date<cr>", desc = "+Date" },
    { "<leader>m", ":set filetype=", desc = "Set filetype" },
    { "<leader>n", group = "Switch" },
    { "<leader>nn", "<cmd>set nu! rnu!<cr>", desc = "Switch line number" },
    { "<leader>nw", "<cmd>set wrap!<cr>", desc = "Switch wrap mode" },
    { "<leader>q", group = "EasyMotion" },
    { "<leader>qj", "<Plug>(easymotion-j)", desc = "J motion" },
    { "<leader>qk", "<Plug>(easymotion-k)", desc = "K motion" },
    { "<leader>qs", "<Plug>(easymotion-s2)", desc = "2-Char Search" },
    { "<leader>qt", "<Plug>(easymotion-t2)", desc = "2-Char Search (T)" },
    { "<leader>r", ":%s/", desc = "Replace" },
    { "<leader>s", group = "Split" },
    { "<leader>ss", "<cmd>split<cr><C-w>w", desc = "Split horizontal" },
    { "<leader>sv", "<cmd>vsplit<cr><C-w>w", desc = "Split vertical" },
    { "<leader>w", group = "Window" },
    { "<leader>w,", "<C-w><", desc = "" },
    { "<leader>w.", "<C-w>>", desc = "" },
    { "<leader>x", "<cmd>set paste!<cr>", desc = "Set paste mode" },
    { "<leader>y", '"*y', desc = "Yank" },
    { "<leader>z", group = "FlodMethod" },
    { "<leader>zi", "<cmd>set foldmethod=indent<cr>", desc = "Indent" },
    { "<leader>zk", "<cmd>set foldmethod=marker<cr>", desc = "Marker" },
    { "<leader>zm", "<cmd>set foldmethod=manual<cr>", desc = "Manual" },
    { "<leader>zq", "<cmd>set foldmethod<cr>", desc = "Query current" },
    { "<leader>zs", "<cmd>set foldmethod=syntax<cr>", desc = "Syntax" },
    { "<leader>zz", "<cmd>set nofoldenable<cr>", desc = "Nofoldenable" },
    { "<leader>p", '"*p', desc = "Paste", mode = { "n", "v" } },
  })
