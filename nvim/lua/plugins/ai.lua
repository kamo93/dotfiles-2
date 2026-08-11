-- Asistente: Copilot y CopilotChat.
local is_vscode = vim.g.vscode ~= nil

return {
  {
    "github/copilot.vim",
    cond = not is_vscode,
    init = function()
      require("config.copilot")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cond = not is_vscode,
    dependencies = { "github/copilot.vim", "nvim-lua/plenary.nvim" },
    build = "make tiktoken",
    config = function()
      require("config.copilot-chat")
    end,
  },
}
