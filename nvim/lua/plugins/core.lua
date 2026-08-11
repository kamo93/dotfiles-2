-- Plugins generales: edición de texto, undo y utilidades sin categoría propia.
local is_vscode = vim.g.vscode ~= nil

return {
  { "tpope/vim-surround", cond = not is_vscode },
  { "tpope/vim-repeat", cond = not is_vscode },
  { "tpope/vim-sensible", cond = not is_vscode },
  {
    "mg979/vim-visual-multi",
    init = function()
      require("config.vim-visual-multi")
    end,
  },
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  { "mbbill/undotree" },
}
