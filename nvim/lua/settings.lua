vim.g.do_filetype_lua = 1

-- neovim config https://neovim.io/doc/user/nvim.html
vim.o.hlsearch          = true                                  -- When you end search for a pattern highlights	all the results
vim.o.ignorecase        = true                                  -- when search in buffer with / the search with ignore casing
vim.o.incsearch         = true                                  -- While searching with / it will highlight the current matches
vim.o.smartcase         = true                                  -- when searching / if you have uppercase will search with uppercase if not just make a ignorecase search
vim.o.number            = true                                  -- show number aside but also with relativenumber let the actual number persist instead being 0
vim.o.autoindent        = true                                  -- copy the current indent from previous line
vim.o.relativenumber    = true                                  -- set relative numbers aside
vim.o.shortmess         = vim.o.shortmess.."c"                  -- Avoid showing message extra message when using completion but keep showing other important messages
vim.o.tabstop           = 2                                     -- the tab spaces default 8 change to 2
vim.cmd("set softtabstop=0 expandtab")
vim.cmd("set cursorline")                                       -- hightlight current line number
vim.o.shiftwidth        = 2                                     -- define how many columns of whitespace a level of indentation worth
vim.o.smarttab          = true                                  -- when expandtab and softtabstop is different from shiftwidth let you always put a tab after endline??
vim.o.smartindent       = true                                  -- make a indent more 'intelligent'
vim.o.scrolloff         = 16                                    -- don't let you scroll up 16 lines from the top and down 16 lines from the bottom let you in the middle of the screen
vim.cmd("set nowrap")                                           -- doesnt change the text in the buffer no matter if the line is longer that width set
vim.cmd("set noswapfile")                                       -- swapfiles are tmp file from the current buffer if you dont save disable becuase its a lot probably better option autosaving
vim.cmd("set nobackup")                                         -- after you overwrite a buffer save a copy this disable that I use undotree
vim.cmd("set nocompatible")                                     -- ??
vim.cmd("set noshowmode")                                       -- hide --INSERT-- mostly for statusline dont appear twice
vim.cmd("exec 'set undodir='.stdpath('config').'/undodir'")     -- set the folder for the undotree plugin
vim.o.undofile          = true
vim.cmd("set colorcolumn=100")                                  -- spaces to show the color column
vim.o.completeopt       = 'menuone,noinsert,noselect'           -- config for ui lsp works correctly
vim.o.mouse             = 'a'                                   -- mouse active for all modes
vim.cmd("set signcolumn=yes")                                   -- column on left
vim.o.linespace         = 10                                    -- spaces between lines
vim.o.updatetime        = 300                                   -- run faster lsp default 1000
vim.o.autoread          = true                                  -- reload file if the file change because some outside vim interaction
vim.o.hidden            = true                                  -- let you leave current bf no matter is saved or not
-- vim.o.clipboard         = "unnamedplus"                      -- this suppost to anything yank will go to system clipboard comment this since its also sending to system clipboard anything like delete or any yank
vim.api.nvim_command('autocmd FocusGained * checktime')
vim.api.nvim_command('autocmd CursorHold * checktime')
vim.o.termguicolors     = true                                  -- enables 24 bit rgb color
vim.o.laststatus        = 3                                     -- new neovim feature to have just one main status lines
vim.cmd("set splitright")                                       -- open vssplit on the right
vim.cmd("set splitbelow")                                       -- open split on the bottom

-- vim.g.is_bash           = 1                                     -- Automatically stablish .sh files as bash files ## more info -> https://stackoverflow.com/questions/7450395/vim-inconsistently-syntax-highlighting-bash-files
-- vim.cmd("let g:is_bash=1")

vim.cmd[[
  let g:is_bash=1
  runtime! macros/matchit.vim
]]

-- local group = vim.api.nvim_create_augroup('js-autocmd', {})
-- local js_pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' }

-- vim.api.nvim_create_autocmd('bufwritepre', {
--   pattern = js_pattern,
--   command = 'silent! eslintfixall',
--   group = group
-- })

-- vim.api.nvim_create_autocmd('BufWinEnter', {
--   pattern = js_pattern,
--   callback = function ()
--     local buf = vim.api.nvim_get_current_buf()
--     vim.api.nvim_buf_set_keymap(buf, 'n', '<leader>l', "yiwoconsole.log('<esc>pa',<esc>pa)<esc>", { noremap = true })
--   end,
--   group = group
-- })

-- vim.api.nvim_create_autocmd('TermOpen', {
--   group = vim.api.nvim_create_augroup('term-open-custom-au', {}),
--   pattern = "term://*",
--   callback = function ()
--     local bufnr = vim.api.nvim_get_current_buf()
--     print(vim.inspect(vim.bo[bufnr]))
--     print(vim.inspect(vim.bo))
--     print(bufnr)
--     -- vim.api.nvim_buf_set_option(bufnr, 'number', false)
--     print(vim.api.nvim_buf_get_option(bufnr, 'relativenumber'))
--     -- vim.opt_local.nonumber = true
--     -- vim.opt_local.norelativenumber = true
--   end
-- })
vim.api.nvim_create_autocmd('User', {
  pattern = 'FugitiveIndex',
  group = vim.api.nvim_create_augroup('FugitiveIndexCustom', { clear = true }),
  callback = function ()
    vim.keymap.set('n', 'cc', ":vertical Git commit <CR>", { buffer = true })
  end
})
