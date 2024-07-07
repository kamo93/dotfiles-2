local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  return
end
local actions = require("telescope.actions")
-- local z_utils = require("telescope._extensions.zoxide.utils")
-- local entry_display = require "telescope.pickers.entry_display"
-- local strings = require "plenary.strings"

telescope.setup({
  defaults = {
    scroll_strategy = "limit",
    dynamic_preview_title = true
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ['d'] = actions.delete_buffer,
          ['s'] = actions.add_selection,
        }
      }
    },
    grep_string = {
      theme = "ivy"
    }
  },
  extensions = {
    recent_files = {
      initial_mode = "normal",
      mappings = {
        n = {
          ['d'] = actions.delete_buffer,
          ['s'] = actions.add_selection,
        }
      }
    },
    live_grep_args = {
      mappings = {
        i = {
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
          ["<C-k>"] = require('telescope-live-grep-args.actions').quote_prompt(),
          ["<C-i>"] = require('telescope-live-grep-args.actions').quote_prompt({ postfix = " --iglob " })
        },
        n = {
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
        },
      },
      theme = "dropdown",
      layout_config = {
        anchor = 'N',
        mirror = true,
        width = 0.7,
        height = 0.4
      },
    },
    -- ["ui-select"] = {
    --   specific_opts = {
    --     ["recent_files"] = {
    --       make_indexed = function(items)
    --         local indexed_items = {}
    --         local widths = {
    --           idx = 0,
    --           command_title = 0,
    --           client_name = 0,
    --         }
    --         for idx, item in ipairs(items) do
    --           local client = vim.lsp.get_client_by_id(item[1])
    --           local entry = {
    --             idx = idx,
    --             ["add"] = {
    --               command_title = item[2].title:gsub("\r\n", "\\r\\n"):gsub("\n", "\\n"),
    --               client_name = client and client.name or "",
    --             },
    --             text = item,
    --           }
    --           table.insert(indexed_items, entry)
    --           widths.idx = math.max(widths.idx, strings.strdisplaywidth(entry.idx))
    --           widths.command_title = math.max(widths.command_title, strings.strdisplaywidth(entry.add.command_title))
    --           widths.client_name = math.max(widths.client_name, strings.strdisplaywidth(entry.add.client_name))
    --         end
    --         return indexed_items, widths
    --       end,
    --       make_displayer = function(widths)
    --         return entry_display.create {
    --           separator = "  ",
    --           items = {
    --             { width = widths.idx + 1 }, -- +1 for ":" suffix
    --             { width = widths.command_title },
    --             { width = widths.client_name },
    --           },
    --         }
    --       end,
    --       make_display = function(displayer)
    --         return function(e)
    --           return displayer {
    --             { e.value.idx .. ":", "TelescopePromptPrefix" },
    --             { e.value.add.command_title },
    --             { e.value.add.client_name, "TelescopeResultsComment" },
    --           }
    --         end
    --       end,
    --       make_ordinal = function(e)
    --         return e.idx .. e.add["command_title"]
    --       end,
    --     }
    --   }
    -- }
    -- frecency = {
    --   show_scores = true,
    --   show_unindexed = true,
    --   ignore_patterns = {"*.git/*", "*/tmp/*"},
    --   disable_devicons = false,
    -- },
    -- zoxide = {
    --   prompt_title = "[ Walking on the shoulders of TJ ]",
    --   mappings = {
    --     default = {
    --       after_action = function(selection)
    --         print("Update to (" .. selection.z_score .. ") " .. selection.path)
    --       end
    --     },
    --     ["<C-s>"] = {
    --       before_action = function(selection) print("before C-s") end,
    --       action = function(selection)
    --         vim.cmd.edit(selection.path)
    --       end
    --     },
    --     ["<C-q>"] = { action = z_utils.create_basic_command("split") },
    --     ["<C-f>"] = {
    --       keepinsert = true,
    --       action = function(selection)
    --         print('selection path'..selection.path)
    --         require("telescope.builtin").find_files({ cwd = selection.path })
    --       end
    --     },
    --   },
    -- },
  }
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- telescope.load_extension("fzf")
-- currently using zf-native cause prioritize filenames nor the path, regarding performance its almost the same on big repos
telescope.load_extension("zf-native")
telescope.load_extension("recent_files")
-- telescope.load_extension('ui-select')
-- telescope.load_extension("zoxide")

local builtin = require("telescope.builtin")
vim.keymap.set(
  "n",
  "<leader>ff",
  ":lua require'telescope.builtin'.find_files({ hidden = true, dynamic_preview_title = true})<cr>",
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<leader>fg",
  function()
    require('telescope').extensions.live_grep_args.live_grep_args({ history = { limit = 10 } })
  end,
  { noremap = true, silent = true }
)

local function setSelectedValue()
  local _, startRow, startCol = unpack(vim.fn.getpos("'<"))
  local _, endRow, endCol = unpack(vim.fn.getpos("'>"))
  local selected_text = vim.api.nvim_buf_get_text(0, startRow - 1, startCol - 1, endRow - 1, endCol, {})
  local search_query = selected_text[1]
  builtin.grep_string({ search = search_query, initial_mode = 'normal' })
end

_G.setSelectedValue = setSelectedValue;

vim.keymap.set(
  'x',
  '<leader>sy',
  ':<C-U> lua setSelectedValue()<CR>',
  { silent = true }
)

vim.keymap.set(
  "n",
  "<leader>pw",
  function()
    builtin.grep_string({ initial_mode = 'normal', prompt_title = "Looking for > " .. vim.fn.expand("<cword>"), dynamic_preview_title = true })
  end,
  { noremap = true, silent = true }
)
-- nnoremap <leader>fb <cmd>lua require("telescope.builtin").buffers()<cr>
vim.keymap.set(
  "n",
  "<leader>fb",
  ":lua require('telescope.builtin').buffers({ initial_mode = 'normal' })<cr>",
  { noremap = true, silent = true }
)
-- nnoremap <leader>fh <cmd>lua require("telescope.builtin").help_tags()<cr>
vim.keymap.set(
  "n",
  "<leader>fh",
  ":lua require('telescope.builtin').help_tags()<cr>",
  { noremap = true, silent = true }
)
-- nnoremap <leader>gg <cmd>lua require("telescope.builtin").git_files()<cr>
vim.keymap.set(
  "n",
  "<leader>gst",
  ":lua require('telescope.builtin').git_status({ initial_mode = 'normal' })<cr>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>gp",
  ":lua require('telescope.builtin').git_files()<cr>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>gg",
  ":lua require('telescope.builtin').git_files({ path_display = { shorten = 1 }, show_untracked = true, dynamic_preview_title = true })<cr>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>gr",
  ":Telescope lsp_references theme=ivy initial_mode=normal <cr>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>ta",
  ":lua require('telescope.builtin').lsp_code_actions()<cr>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader><leader>",
  function()
    telescope.extensions.recent_files.pick({ only_cwd = true })
  end,
  { noremap = true, silent = true }
)

-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader><leader>",
--   "<Cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD' })<CR>",
--   {noremap = true, silent = true}
-- )

-- vim.keymap.set(
--   "n",
--   "<leader>tez",
--   "<cmd>lua require('telescope').extensions.z.list{cwd = vim.fn.getcwd()}<cr>",
--   { noremap = true, silent = true }
-- )
