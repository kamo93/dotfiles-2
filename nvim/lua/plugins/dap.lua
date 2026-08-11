-- Debugging: nvim-dap + interfaz UI + virtual text.
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("config.dap")
    end,
  },
  { "nvim-neotest/nvim-nio" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("config.nvim-dap-ui")
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("config.nvim-dap-virtual-text")
    end,
  },
}
