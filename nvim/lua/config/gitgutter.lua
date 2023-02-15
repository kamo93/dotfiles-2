vim.g["gitgutter_terminal_reports_focus"]=0
-- nmap [h <Plug>(GitGutterPrevHunk)
vim.keymap.set('n', '[h', '<Plug>(GitGutterPrevHunk)', { silent = true })
-- nmap ]h <Plug>(GitGutterNextHunk)
vim.keymap.set('n', ']h', '<Plug>(GitGutterNextHunk)', { silent = true })
-- nmap ghp <Plug>(GitGutterPreviewHunk)
vim.keymap.set('n', 'ghp', '<Plug>(GitGutterPreviewHunk)', { silent = true })
vim.keymap.set('n', 'ghu', '<Plug>(GitGutterUndoHunk)', { silent = true })
