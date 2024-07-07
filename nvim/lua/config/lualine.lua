require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 
      { 
        -- manually add this symbols becuase there some change on nerdfont 
        -- and lualine update those icons but there are not regnoize on linux right now june 15
        -- PR with changes https://github.com/nvim-lualine/lualine.nvim/pull/1033/files
        "diagnostics",
        symbols = { 
          error = " ",
          warn = " ",
          info = " ",
          hint = " "
        },
      }
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
