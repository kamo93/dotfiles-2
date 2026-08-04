-- nvim-tree suggest disable the default neovim nettree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

require("plugins")
require("settings")
require("mappins")
require("config.comment")
-- require("config.colorscheme")
if (not vim.g.vscode) then
  require("config._telescope")
  require("config.cmp")
  require("config.nvim-tree")
  require("config.treesitter")
  require("config.mason") -- add before lspconfig according to readme mason
  require("config.copilot")
  require("config.copilot-chat")
end
require("config.lualine")
-- require("config.null-ls")
require("config.vim-visual-multi")
require("config.gitgutter")
require("config.autoclose-tag")
require("config.markdown-preview")
require("config.vim-hexokinase")
require("config.colorizer")
require("config._lspconfig")
require('config.lsp-signature')
require("config.indent-blankline")
require("config.dap")
require("config.nvim-dap-ui")
require("config.nvim-dap-virtual-text")
print("heree at the end")
