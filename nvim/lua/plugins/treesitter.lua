-- Sintaxis: nvim-treesitter + módulo autotag.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("config.treesitter")
    end,
  },
}
