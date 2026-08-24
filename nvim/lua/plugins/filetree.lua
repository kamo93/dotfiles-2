-- Explorador de archivos: nvim-tree + iconos.
local is_vscode = vim.g.vscode ~= nil

return {
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   cond = not is_vscode,
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     require("config.nvim-tree")
  --   end,
  -- },
  -- { "nvim-tree/nvim-web-devicons" },
}
