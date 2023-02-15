local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(function(use)
	-- My plugins here

	-- color theme
	-- use "olimorris/onedarkpro.nvim"
  use {"rebelot/kanagawa.nvim", commit = 'fc2e308'}

	-- color square preview
	use { "rrethy/vim-hexokinase", run = "make hexokinase" }

	-- general plugins
	use "nvim-lualine/lualine.nvim"
	use "nvim-tree/nvim-web-devicons"
	use {
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		tag = "nightly"
	}
	use "tpope/vim-surround"
	use "mg979/vim-visual-multi"
	use "jiangmiao/auto-pairs"
	use "mbbill/undotree"
	use "tpope/vim-commentary" -- TODO comment.nvim gave a chance
	use "tpope/vim-repeat"

	-- git
	use "tpope/vim-fugitive"
	use "airblade/vim-gitgutter"

	-- plugins using treesitter power
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}  -- We recommend updating the parsers on update
	use "p00f/nvim-ts-rainbow"
	use "windwp/nvim-ts-autotag"
	use "JoosepAlviste/nvim-ts-context-commentstring"
	use "lukas-reineke/indent-blankline.nvim"
	use "nvim-treesitter/playground"

	-- Neovim LSP
	use "neovim/nvim-lspconfig"

	-- Autocompletion
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "hrsh7th/nvim-cmp"
	use "ray-x/lsp_signature.nvim"
	-- For vsnip usersp.
	use "L3MON4D3/LuaSnip"
	use "saadparwaiz1/cmp_luasnip"
	use "rafamadriz/friendly-snippets"

	-- Telescope
	-- based on https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/lua/plugins.lua#L64
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
	use {
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		wants = {
			"plenary.nvim"
		},
	}
  use {
    "nvim-telescope/telescope-z.nvim",
  }

  use {
    "nvim-telescope/telescope-frecency.nvim",
    requires = {"tami5/sqlite.lua"}
  }


	-- Javascript Typescript
  use "jose-elias-alvarez/nvim-lsp-ts-utils"
	-- use "dense-analysis/ale"
	use "jose-elias-alvarez/null-ls.nvim"

	-- Markdown
	use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install", cmd = "MardownPreview" }

	use { "dstein64/vim-startuptime", cmd = "StartupTime" }
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
