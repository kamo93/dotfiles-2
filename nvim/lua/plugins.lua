local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(function(use)
  -- My plugins here
  -- general plugins
  -- Order plugins
  -- 1. Plugins without any config file(since they dont have any file config its not necessary to sort them. 
  -- 2. Plugins with config file follow the order that they are require on init.lua
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-sensible"

  -- git
  use "tpope/vim-fugitive"
  use "airblade/vim-gitgutter"

  -- 2. With config files
  use "numToStr/Comment.nvim"
  -- color theme
  -- use "olimorris/onedarkpro.nvim"
  -- use {"rebelot/kanagawa.nvim", commit = 'fc2e308'}
  -- use "folke/tokyonight.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Telescope
  -- based on https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/lua/plugins.lua#L64
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim"
    },
    config = function ()
      require("telescope").load_extension("live_grep_args")
    end,
    wants = {
      "plenary.nvim"
    },
  }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "natecraddock/telescope-zf-native.nvim"
  use "smartpde/telescope-recent-files"

  -- use {
  --   "nvim-telescope/telescope-z.nvim",
  --   config = function ()
  --     require"telescope".load_extension('z')
  --   end
  -- }

  -- use {
  --   "jvgrootveld/telescope-zoxide",
  -- }

  -- use {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   config = function ()
  --     require"telescope".load_extension("frecency")
  --   end,
  --   requires = { 'kkharji/sqlite.lua' }
  -- }
  --

  -- Autocompletion
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  use "ray-x/lsp_signature.nvim"
  -- For vsnip usersp.
  use({
    "L3MON4D3/LuaSnip",
    tag = "v2,*",
    run = "make install_jsregexp"
  })
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"

  use "nvim-tree/nvim-web-devicons"
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    }
  }

  use "nvim-lualine/lualine.nvim"
  use "mg979/vim-visual-multi"
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }
  use "mbbill/undotree" -- plugins using treesitter power

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use "p00f/nvim-ts-rainbow"
  use "windwp/nvim-ts-autotag"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "lukas-reineke/indent-blankline.nvim"
  use "nvim-treesitter/playground"
  -- 
  -- 	-- Neovim LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  }
  use "neovim/nvim-lspconfig"
  -- 
  -- 
  -- 	-- Javascript Typescript
  --   use "jose-elias-alvarez/nvim-lsp-ts-utils"
  -- 	-- use "dense-analysis/ale"
  -- 	-- use "jose-elias-alvarez/null-ls.nvim"
  -- 
  --   -- override filetype for empty files .tf
  --   -- use {
  --   --   "nathom/filetype.nvim",
  --   --   config = function()
  --   --     require("filetype").setup {
  --   --       overrides = {
  --   --         extensions = {
  --   --           tf = "terraform",
  --   --           tfvars = "terraform",
  --   --           tfstate = "json",
  --   --         },
  --   --       },
  --   --     }
  --   --   end,
  --   -- }
  -- 
  -- Dap plugin
  use "mfussenegger/nvim-dap"
  use "nvim-neotest/nvim-nio"
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
  use "theHamsta/nvim-dap-virtual-text"


  -- Markdown
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  use { "dstein64/vim-startuptime", cmd = "StartupTime" }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -- use {
  --   "ahmedkhalf/project.nvim",
  --   config = function()
  --     require("project_nvim").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }
  if Packer_bootstrap then
    require("packer").sync()
  end
end)
