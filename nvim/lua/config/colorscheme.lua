
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
-- require("tokyonight").setup({
--   style = "night",
--   transparent = true,
--   styles = {
--     keywords = { italic = true },

--   }
-- })
-- vim.cmd("colorscheme tokyonight")

require("catppuccin").setup({
  flavour = "mocha",
  highlights = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  transparent_background = true,
  styles = {
    keywords = { "italic" },
    types = { "italic" },
    comments = { "italic" },
  },
  -- colors from https://github.com/catppuccin/nvim/discussions/323#discussioncomment-6488799
  color_overrides = {
    mocha = {
      rosewater = "#efc9c2",
      flamingo = "#ebb2b2",
      pink = "#f2a7de",
      mauve = "#b889f4",
      red = "#ea7183",
      maroon = "#ea838c",
      peach = "#f39967",
      yellow = "#eaca89",
      green = "#96d382",
      teal = "#78cec1",
      sky = "#91d7e3",
      sapphire = "#68bae0",
      blue = "#739df2",
      lavender = "#a0a8f6",
      text = "#b5c1f1",
      subtext1 = "#a6b0d8",
      subtext0 = "#959ec2",
      overlay2 = "#848cad",
      overlay1 = "#717997",
      overlay0 = "#63677f",
      surface2 = "#505469",
      surface1 = "#3e4255",
      surface0 = "#2c2f40",
      base = "#1a1c2a",
      mantle = "#141620",
      crust = "#0e0f16",
    },
  },
})

local palette = require('catppuccin.palettes.mocha')

vim.cmd("colorscheme catppuccin-mocha")

-- Overrides float menus
vim.api.nvim_set_hl(0, 'Pmenu', { bg = palette.surface0 })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = palette.surface0 })
vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = palette.surface0 })
vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = palette.surface0 })
vim.cmd[[hi Normal guibg=none]]
