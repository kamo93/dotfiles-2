-- vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
--   expr = true,
--   replace_keycodes = false
-- })

vim.api.nvim_set_keymap('i', '<C-M-]>', 'copilot#Accept()', {expr = true, silent = true, noremap = false, replace_keycodes = false})
vim.g.copilot_no_tab_map = true


