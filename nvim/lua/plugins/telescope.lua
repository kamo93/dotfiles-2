-- Buscador fuzzy: telescope + extensiones (live-grep, zf-native, recent-files).
local is_vscode = vim.g.vscode ~= nil

return {
  {
    "nvim-telescope/telescope.nvim",
    cond = not is_vscode,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "natecraddock/telescope-zf-native.nvim",
      "smartpde/telescope-recent-files",
    },
    config = function()
      require("config._telescope")
    end,
  },
}
