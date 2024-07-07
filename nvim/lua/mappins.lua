vim.keymap.set('n', '<Spce>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

vim.keymap.set('n', '<esc>', '<silent>', { noremap = true, silent = true })

-- save current buffer with leader s
vim.keymap.set('', '<Leader>s', ':wa<CR>', { silent = true })

-- better window movement
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })



-- better indenting on visual mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- move between buffers using TAB
vim.keymap.set('n', "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set('n', "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })

-- close buffer by change to previous buffer and then remove previous buffer
vim.keymap.set('n', '<leader>d', ':bp|bd#<cr>', { silent = true })

-- -- resize window easier
vim.keymap.set('n', '<C-Up>', ':resize -5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', ':resize +5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +5<CR>', { noremap = true, silent = true })

-- insert empty new line without entering insert mode
vim.keymap.set('n', '<leader>o', 'o<Esc>0"_D', { noremap = true })
vim.keymap.set('n', '<leader>O', 'O<Esc>0"_D', { noremap = true })

-- remap remove hightlight with esc
vim.keymap.set('n', '<leader>n', ':noh<cr>', { silent = true })

-- move previous open buffer easily
vim.keymap.set('n', 'U', '<C-^>', { noremap = true, silent = true })

-- **** Term mappins ****
vim.keymap.set('t', '<C-\\>N', "<C-\\><C-n>", { noremap = true, silent = true }) -- exit terminal mode
vim.keymap.set('n', '<leader>t', ":tabnew <CR>:terminal<CR>", { noremap = true, silent = true }) -- new terminal
vim.keymap.set('t', "<C-\\>c", "<C-\\><C-n>gT", { noremap = true, silent = false }) -- move previous tab in terminal mode usually the previous tab should be cwd
-- Movement easy while being on terminal mode
vim.keymap.set('t', "<C-\\>l", "<C-\\><C-n><C-w>li", { noremap = true, silent = false })
vim.keymap.set('t', "<C-\\>h", "<C-\\><C-n><C-w>hi", { noremap = true, silent = false })
vim.keymap.set('t', "<C-\\>k", "<C-\\><C-n><C-w>ki", { noremap = true, silent = false })
vim.keymap.set('t', "<C-\\>j", "<C-\\><C-n><C-w>ji", { noremap = true, silent = false })
vim.keymap.set('t', '<C-\\>v', '<C-\\><C-n>:vsplit +term<CR>', { noremap = true, silent = true }) -- Terminal mode create split vertical term
vim.keymap.set('t', '<C-\\>s', '<C-\\><C-n>:split +term<CR>', { noremap = true, silent = true }) -- Terminal mode create split horizontal term

-- **** End term mappins ****

-- quickfix mappings
-- vim.keymap.set('n', '<C-C>', ":cclose<CR>", { noremap = true, silent = true })

-- paste with indent
vim.keymap.set('n', 'p', "p'[v']=<CR>", { noremap = true, silent = true })

-- dont lost previous yank
vim.keymap.set("x", "<leader>p", "\"_dP")

-- copy & paste to clipboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>Y', '"+Y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>v', '"+p', { noremap = true, silent = true })

vim.keymap.set('n', 'J', 'mzJ`z')

-- move and center
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')


-- toggle quickfix 
function ToggleQuickFix()
  local quickfix_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      quickfix_open = true
      break
    end
  end
  if quickfix_open then
    vim.cmd('cclose')
  end
  if not quickfix_open and #vim.fn.getqflist() > 0 then 
    vim.cmd('copen')
  end
end

vim.keymap.set('n', '<C-Q>', ToggleQuickFix, { noremap = true, silent = true })
-- move fast on quickfix list
vim.keymap.set('n', '<leader>k', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>cprev<CR>zz')

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

