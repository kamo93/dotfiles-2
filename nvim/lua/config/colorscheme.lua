
-- -- colorscheme config onedark
-- -- https://github.com/olimorris/onedark.nvim
-- local onedarkpro = require("onedarkpro")
-- onedarkpro.setup {
-- 	theme = "onedark_vivid",
-- 	colors = {
-- 		onedark = {
-- 			-- Vivid colors from https://github.com/Binaryify/OneDark-Pro
-- 			red = "#ef596f",
-- 			green = "#89ca78",
-- 			cyan = "#2bbac5",
-- 			purple = "#d55fde",
-- 		},
-- 		onedark_vivid = {
-- 			-- Vivid colors from https://github.com/Binaryify/OneDark-Pro
-- 			red = "#ef596f",
-- 			green = "#89ca78",
-- 			cyan = "#2bbac5",
-- 			purple = "#d55fde",
-- 		}
-- 	},
-- 	hlgroups = {},
-- 	styles = {
-- 		strings = "NONE",
-- 		comments = "bold,italic",
-- 		keywords = "italic",
--     functions = "NONE",
-- 		variables = "NONE",
-- 	},
-- 	options = {
-- 		bold = true, -- Use the themes opinionated bold styles?
-- 		italic = true, -- Use the themes opinionated italic styles?
-- 		underline = true, -- Use the themes opinionated underline styles?
-- 		undercurl = true, -- Use the themes opinionated undercurl styles?
-- 		cursorline = false, -- Use cursorline highlighting?
-- 		transparency = false, -- Use a transparent background?
-- 		terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
-- 		window_unfocussed_color = true, -- When the window is out of focus, change the normal background?
-- 	}
-- }
-- onedarkpro.load()


-- vim.cmd("colorscheme onedarkpro")
--
require('kanagawa').setup({
  overrides = {
    Visual = {
      bg = "#111222"
    }
  }
})
vim.cmd("colorscheme kanagawa")
vim.cmd [[hi Normal guibg=none]]
