set nu rnu
set title
"set autochdir
set background=dark
set signcolumn=yes
set ttimeoutlen=0
set wildmenu wildmode=longest:full,full
set completeopt=noinsert,menuone,noselect
set inccommand=split
set clipboard+=unnamedplus
set backspace=indent,eol,start
"set list
"set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
set list listchars=tab:»-,trail:·,extends:»,precedes:«
set cursorline
set hidden
set mouse=a
set splitbelow splitright
set nobackup
set noswapfile
set nobomb

set autoindent
set smartindent
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2

filetype plugin indent on
syntax on

""" For neovide
if exists("g:neovide")
  set guifont=CaskaydiaCove\ NF\ Mono:h10:i:#e-subpixelantialias:#h-none
  let g:neovide_cursor_animation_length = 0
endif

""" Setup color
set termguicolors

""" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

""" Load env
runtime env.local.vim

""" Load Packer
lua require('plugins')
lua require('keymaps')

""" EasyMotion
runtime easymotion.vim

