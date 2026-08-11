-- Interfaz: barra de estado (lualine) y líneas de indentación.
return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.lualine")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.indent-blankline")
    end,
  },
}
