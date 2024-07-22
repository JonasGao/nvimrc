return {

  -- Improvements UI
  { "stevearc/dressing.nvim" },

  -- Notification
  { "MunifTanjim/nui.nvim" },
  { "rcarriga/nvim-notify" },
  { "folke/noice.nvim" },

  -- Which key
  { "folke/which-key.nvim" },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "b0o/nvim-tree-preview.lua",
    },
  },

  -- LSP and Diagnostic
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'j-hui/fidget.nvim' },
  { 'mhartington/formatter.nvim' },
  { 'folke/trouble.nvim',                  dependencies = "kyazdani42/nvim-web-devicons" },
  { 'glepnir/lspsaga.nvim',                dependencies = 'nvim-tree/nvim-web-devicons' },

  -- Colorschema
  { 'Tsuzat/NeoSolarized.nvim' },

  -- Statusline
  { 'hoob3rt/lualine.nvim',                dependencies = 'kyazdani42/nvim-web-devicons' },

  -- Easy motion
  { 'easymotion/vim-easymotion' },

  -- Visual Multi
  { 'mg979/vim-visual-multi' },

  -- Autocompletion
  { 'onsails/lspkind-nvim' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'saadparwaiz1/cmp_luasnip' }, -- Snippets source for nvim-cmp
  { 'L3MON4D3/LuaSnip' },         -- Snippets plugin

  -- Quick Scope
  { 'unblevable/quick-scope' },

  -- Treesitter more highlight
  { 'nvim-treesitter/nvim-treesitter',     run = ':TSUpdate' },

  -- Show indent line
  { 'lukas-reineke/indent-blankline.nvim', dependencies = 'tjdevries/colorbuddy.nvim' },

  -- Fuzzy finder
  { 'nvim-telescope/telescope.nvim',       version = '0.1.4',                            dependencies = 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = function(plugin)
      local obj = vim.system({ 'cmake', '-S.', '-Bbuild', '-DCMAKE_BUILD_TYPE=Release' }, { cwd = plugin.dir }):wait()
      if obj.code ~= 0 then error(obj.stderr) end
      obj = vim.system({ 'cmake', '--build', 'build', '--config', 'Release' }, { cwd = plugin.dir }):wait()
      if obj.code ~= 0 then error(obj.stderr) end
      obj = vim.system({ 'cmake', '--install', 'build', '--prefix', 'build' }, { cwd = plugin.dir }):wait()
      if obj.code ~= 0 then error(obj.stderr) end
    end
  },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'smartpde/telescope-recent-files' },

  -- Scrollview
  { 'dstein64/nvim-scrollview' }
}
