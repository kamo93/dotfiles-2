-- Comentado de código: Comment.nvim + contexto treesitter para JSX/TSX.
return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("config.comment")
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("config.ts-context-commentstring")
    end,
  },
}
