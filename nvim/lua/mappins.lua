vim.api.nvim_set_keymap('n', '<Spce>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<esc>', '<silent>', { noremap = true, silent = true })

-- save current buffer with leader s
vim.api.nvim_set_keymap('', '<Leader>s', ':w<CR>', { silent = true })

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { silent = true })

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- move between buffers using TAB
vim.api.nvim_set_keymap('n', "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })
-- delete buffer
vim.keymap.set('n', '<leader>d', ':bd<cr>', { silent = true })

-- -- resize window easier
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +5<CR>', { noremap = true, silent = true })

-- insert empty new line without entering insert mode
vim.keymap.set('n', '<leader>o', 'o<Esc>0"_D', { noremap = true })
vim.keymap.set('n', '<leader>O', 'O<Esc>0"_D', { noremap = true })

-- remap remove hightlight with esc
vim.keymap.set('n', '<leader>hn', ':noh<cr>', { silent = true })

-- move previous open buffer easily
vim.keymap.set('n', '<Backspace>', '<C-^>', { noremap = true, silent = true })

-- exit terminal mode
vim.keymap.set('t', '<C-\\>N', "<C-\\><C-n>", { noremap = true, silent = true })

-- new terminal
vim.keymap.set('n', '<leader>t', ":tabnew <CR>:terminal<CR>", { noremap = true, silent = true })

-- quickfix mappings
vim.keymap.set('n', '<leader>qc', ":cclose<CR>", { noremap = true, silent = true })

-- copy & paste to clipboard
vim.keymap.set('v', '<leader>c', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true, silent = true })

-- move and center
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })

-- vim.keymap.set(
--   'n', 
--   '<leader>l', 
--   function() 
--     local buf = vim.api.nvim_get_current_buf()
--     local ft = vim.api.nvim_buf_get_option(buf, "filetype")
--     local js_languages = { javascript = true, javascriptreact = true, typescript = true, typescriptreact = true }
--     if js_languages[ft] then
      
--     end

--   end
-- )

