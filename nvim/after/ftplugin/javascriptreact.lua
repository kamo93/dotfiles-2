
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function ()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_keymap(buf, 'n', '<leader>l', "yiwoconsole.log('<esc>pa',<esc>pa)<esc>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, 'v', '<leader>l', "yoconsole.log('<esc>pa',<esc>pa)<esc>", { noremap = true, silent = true })
  end,
  group = group
})
