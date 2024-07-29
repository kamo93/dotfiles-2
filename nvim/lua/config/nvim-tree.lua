-- setup with all defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`).
-- :h nvim-tree-setup
--

local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.8   -- You can change this too


require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  on_attach = function (bufnr)
    local api = require("nvim-tree.api")

    -- ALWAYS KEEP THIS WHILE HAVING A CUSTOM ON_ATTACH
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "<esc>", api.tree.close, { buffer = bufnr, noremap = true })
  end,
  hijack_cursor = false,
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  select_prompts = false,
  sort = {
    sorter = "name",
    folders_first = true,
    files_first = false
  },
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
    preserve_window_proportions = true,
    number = false,
    relativenumber = true,
    signcolumn = "yes",
    centralize_selection = false,
    cursorline = true
  },
  renderer = {
    indent_width = 4,
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      web_devicons = {
        file = {
          enable = true,
          color = true
        },
        folder = {
          enable = false,
          color = true,
        }
      },
      git_placement = "before",
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = {
      enable = false,
      ignore_list = {}
    },
    exclude = false
  },
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    enable = true,
    git_ignored = true,
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    no_bookmark = false,
    custom = {},
    exclude = {},
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  modified = {
    enable = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    disable_for_dirs = {},
    timeout = 400,
    cygwin_support = false,
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
    cmd = "gio trash",
  },
  ui = {
    confirm = {
      trash = true,
      remove = true,
      default_yes = false
    }
  },
  tab = {
    sync = {
      open = false,
      close = false,
      ignore = {}
    }

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
