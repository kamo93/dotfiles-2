vim.keymap.set(
  'n',
  '<C-s>',
  '<Plug>MarkdownPreview',
  { silent = true }
)
vim.keymap.set(
  'n',
  '<M-s>',
  '<Plug>MarkdownPreviewStop',
  { silent = true }
)
vim.keymap.set(
  'n',
  '<C-p>',
  '<Plug>MarkdownPreviewToggle',
  { silent = true }
)
vim.g['mkdp_auto_close'] = 0
