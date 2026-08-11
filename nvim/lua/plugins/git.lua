-- Integración con Git: fugitive (worktree/commits) y gitgutter (marcas en columna).
local is_vscode = vim.g.vscode ~= nil

return {
  { "tpope/vim-fugitive", cond = not is_vscode },
  {
    "airblade/vim-gitgutter",
    config = function()
      require("config.gitgutter")
    end,
  },
}
