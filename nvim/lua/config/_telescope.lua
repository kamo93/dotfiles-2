local custom_sorter = require("custom.frecency-sort")
local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
	return
end
local actions = require("telescope.actions")
-- nnoremap <leader>ff <cmd>lua require("telescope.builtin").find_files({ hidden = true })<cr>
vim.keymap.set(
  "n",
  "<leader>ff",
  ":lua require'telescope.builtin'.find_files({ hidden = true })<cr>",
  { noremap = true, silent = true }
)
-- nnoremap <leader>fg <cmd>lua require("telescope.builtin").live_grep()<cr>
vim.keymap.set(
  "n",
  "<leader>fg",
  ":lua require('telescope.builtin').live_grep({ history = { limit = 10 } })<cr>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>pw",
  "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>'), initial_mode = 'normal' })<cr>",
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
  ":lua require('telescope.builtin').git_files({ path_display = { shorten = 1 }, show_untracked = true })<cr>",
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
  "<Cmd>lua require('telescope').extensions.frecency.frecency()<cr>",
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<leader>tez",
  "<cmd>lua require('telescope').extensions.z.list{}<cr>",
  { noremap = true, silent = true }
)

telescope.setup({
  defaults = {
    file_sorter = custom_sorter.frecency_sorter,
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ['d'] = actions.delete_buffer,
          ['s'] = actions.add_selection
        }
      }
    },
    live_grep = {
      mappings = {
        i = {
          ["<C-Down>"] = require('telescope.actions').cycle_history_next,
          ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
        },
        n = {
          ["<C-Down>"] = require('telescope.actions').cycle_history_next,
          ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
        },
      }
    },
    grep_string = {
      theme = "ivy"
    }
  }
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("fzf")

