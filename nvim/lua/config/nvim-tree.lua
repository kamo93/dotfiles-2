-- setup with all defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`).
--

local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.8   -- You can change this too

require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  on_attach = function (bufnr)
    local api = require("nvim-tree.api")
    vim.keymap.set("n", "<esc>", api.tree.close, { buffer = bufnr, noremap = true })
  end,
  view = {
    float = { 
      enable = true,
      quit_on_focus_loss = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
        - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
      -- open_win_config = {
      --   relative = "editor", -- editor works fine it adapts to use split pane tmux, try win did't adapt
      --   border = "rounded",
      --   width = vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) - 20, -- more width that hieght cause screen normally has more width that height
      --   height = vim.api.nvim_win_get_height(vim.api.nvim_get_current_win()) - 10,
      --   row = 4,
      --   col = 8
      -- },
    },
    -- width = "80%", -- more width that hieght cause screen normally has more width that height
    adaptive_size = false, -- if name is too long it adapt to show the complete name
    preserve_window_proportions = true,
    number = false,
    relativenumber = true,
    signcolumn = "yes",
    -- mappings = {
    --   custom_only = false,
    --   list = {
    --     -- user mappings go here
    --   },
    -- },
  },
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
} -- END_DEFAULT_OPTS

vim.keymap.set('n', '<Leader>n', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
