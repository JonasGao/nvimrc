--[[
""" Basic mapping
nnoremap  dw  vb"_d

""" Leaders mapping
let mapleader="\\"
nnoremap  <Leader>Ss  :source $MYVIMRC<CR>
" Switch buffer
nnoremap  <Leader>h   :bp<CR>
nnoremap  <Leader>l   :bn<CR>
nnoremap  <Leader>bl  :ls<CR>
nnoremap  <Leader>bd  :bd<CR>
nnoremap  <Leader>1   :b1<CR>
nnoremap  <Leader>2   :b2<CR>
nnoremap  <Leader>3   :b3<CR>
nnoremap  <Leader>4   :b4<CR>
nnoremap  <Leader>5   :b5<CR>
nnoremap  <Leader>6   :b6<CR>
nnoremap  <Leader>7   :b7<CR>
nnoremap  <Leader>8   :b8<CR>
nnoremap  <Leader>9   :b9<CR>
" Split
nnoremap  <Leader>ss  :split<Return><C-w>w
nnoremap  <Leader>sv  :vsplit<Return><C-w>w
" Resize
nnoremap  <Leader>W,  <C-w><
nnoremap  <Leader>W.  <C-w>>
" Switch foldmethod
nnoremap	<Leader>zs	:set foldmethod=syntax<CR>
nnoremap	<Leader>zi	:set foldmethod=indent<CR>
nnoremap	<Leader>zm	:set foldmethod=manual<CR>
nnoremap	<Leader>zk	:set foldmethod=marker<CR>
nnoremap	<Leader>Z	  :set nofoldenable<CR>
" Insert current date
nnoremap	<Leader>id  :r!date<CR>
inoremap	<C-p>d

]]
--

-- Inspired by https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/keymaps.lua

local function map(mode, key, cmd, desc)
  local o = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, key, cmd, o)
end

map("n", "te", ":tabedit<cr>")
map("n", "<Space>a", "gg0vG$")
map("i", "<C-p>d", "<C-r>=system('date')<CR>")

local wk = require("which-key")
wk.register({
  y = { "*y", "Yank" },
  p = { "*p", "Paste", mode = { "n", "v" } },
  x = { "<cmd>set paste!<cr>", "Set paste mode" },
  r = { "<cmd>bro ol<cr>" },
  n = { "<cmd>set nu! rnu!<cr>", "Switch line number" },
  w = { "<cmd>set wrap!<cr>", "Switch wrap mode" },
  m = { ":set filetype=", "Set filetype" },
}, { prefix = "<leader>" })
