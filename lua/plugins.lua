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

  -- Buffer navigation
  {
    "leath-dub/snipe.nvim",
    keys = {
      {
        "gb",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
  },

  -- LSP and Diagnostic
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "j-hui/fidget.nvim" },
  { "mhartington/formatter.nvim" },
  { "folke/trouble.nvim",                  dependencies = "kyazdani42/nvim-web-devicons" },
  { "glepnir/lspsaga.nvim",                dependencies = "nvim-tree/nvim-web-devicons" },

  -- Colorschema
  { "Tsuzat/NeoSolarized.nvim" },

  -- Statusline
  { "hoob3rt/lualine.nvim",                dependencies = "kyazdani42/nvim-web-devicons" },

  -- Easy motion
  { "easymotion/vim-easymotion" },

  -- Visual Multi
  { "mg979/vim-visual-multi",              lazy = false },

  -- Autocompletion
  { "onsails/lspkind-nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "saadparwaiz1/cmp_luasnip" }, -- Snippets source for nvim-cmp
  { "L3MON4D3/LuaSnip" },         -- Snippets plugin

  -- Quick Scope
  { "unblevable/quick-scope" },

  -- Treesitter more highlight
  { "nvim-treesitter/nvim-treesitter",     run = ":TSUpdate" },

  -- Show indent line
  { "lukas-reineke/indent-blankline.nvim", dependencies = "tjdevries/colorbuddy.nvim" },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.4",
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = function(plugin)
      local do_build = function (script)
        local out = vim.fn.system(script .. " " .. plugin.dir)
        if vim.v.shell_error ~= 0 then
          vim.notify("Failed to build telescope-fzf-native:\n" .. out, vim.log.levels.ERROR)
        end
      end
      if vim.fn.has('mac') == 1 then
        do_build("lib/build_telescope_fzf_native.sh")
      elseif vim.fn.has('win32') == 1 then
        do_build("pwsh lib/build_telescope_fzf_native.ps1")
      elseif vim.fn.has('unix') == 1 then
        do_build("lib/build_telescope_fzf_native.sh")
      end
    end,
  },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "smartpde/telescope-recent-files" },

  -- Scrollview
  { "dstein64/nvim-scrollview" },
}
