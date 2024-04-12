vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Improvements UI
  use {
    "stevearc/dressing.nvim"
  }

  -- Notification
  use {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    "folke/noice.nvim"
  }

  -- Which key
  use {
    "folke/which-key.nvim"
  }

  -- LSP and Diagnostic
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'j-hui/fidget.nvim',
    'mhartington/formatter.nvim',
  }
  use {
    'folke/trouble.nvim',
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }
  use {
    'glepnir/lspsaga.nvim',
    -- Documentation origin use nvim-tree ... but there has already use another ...
    -- requires = 'nvim-tree/nvim-web-devicons',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- Colorschema
  --[[
  use {
    'svrana/neosolarized.nvim',
    requires = 'tjdevries/colorbuddy.nvim'
  }
  ]]
  use { 'Tsuzat/NeoSolarized.nvim' }

  -- Statusline
  use {
    'hoob3rt/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    }
  }

  -- Easy motion
  use 'easymotion/vim-easymotion'

  -- Visual Multi
  use 'mg979/vim-visual-multi'

  -- Autocompletion
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'         -- Snippets plugin

  -- Quick Scope
  use 'unblevable/quick-scope'

  -- Github Copilot
  -- use 'github/copilot.vim'
  -- use {
  --   'zbirenbaum/copilot.lua',
  --   config = function()
  --     require('copilot').setup({
  --       suggestion = { enabled = false },
  --       panel = { enabled = false }
  --     })
  --   end
  -- }
  -- use {
  --   'zbirenbaum/copilot-cmp',
  --   after = { 'copilot.lua' },
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end
  -- }

  -- Treesitter more highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  -- Show indent line
  use {
    'lukas-reineke/indent-blankline.nvim',
    requires = 'tjdevries/colorbuddy.nvim'
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'smartpde/telescope-recent-files'
  }
  -- fzf
  -- use {
  --   'junegunn/fzf',
  --   run = ":call fzf#install()"
  -- }
  -- use 'junegunn/fzf.vim'

  -- Scrollview
  use {
    'dstein64/nvim-scrollview'
  }
end)
