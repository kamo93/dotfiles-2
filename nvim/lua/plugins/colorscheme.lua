-- Temas de color. Agrega aquí cualquier colorscheme nuevo.
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("config.colorscheme")
    end,
  },
}
