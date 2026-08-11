-- LSP: instalación de servidores (mason), lspconfig y configuraciones.
local is_vscode = vim.g.vscode ~= nil

return {
  {
    "williamboman/mason.nvim",
    cond = not is_vscode,
    config = function()
      require("config.mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cond = not is_vscode,
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "neovim/nvim-lspconfig",
    cond = not is_vscode,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("config._lspconfig")
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
	-- for future me this basic help to load all vim lua functions without the need to configure
	-- manually on the lua_ls config
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
