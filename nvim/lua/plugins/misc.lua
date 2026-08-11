-- Plugins sueltos: markdown preview.
return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function()
      require("config.markdown-preview")
    end,
  },
}
