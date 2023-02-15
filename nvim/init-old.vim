filetype plugin on

" neovim config https://neovim.io/doc/user/nvim.html
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" my set config
set nocompatible
set number
set autoindent
set relativenumber
if exists(":ideajoin")
	set ideajoin
endif
if exists(":idearefactormode=keep")
	set idearefactormode=keep
endif
set hlsearch
set ignorecase
set incsearch " incremental search that show partial matches
set smartcase
set shortmess+=c " Avoid showing message extra message when using completion
set noshowmode " hide --INSERT-- 
set tabstop=2 
set softtabstop=0 expandtab
set shiftwidth=2
set smarttab
set smartindent
set nowrap
set scrolloff=16
set noswapfile
set nobackup
exec 'set undodir='.stdpath('config').'/undodir'
set undofile
set colorcolumn=100
set completeopt=menuone,noinsert,noselect
set mouse=a
set signcolumn=yes
set linespace=10
set updatetime=800
set autoread " reload file if the file change because some outside vim interaction
autocmd FocusGained * checktime
autocmd CursorHold * checktime
" setlocal fo-=t fo+=croql works for split the line if its longer
set hidden " let you leave current buffer no matter is saved or not
" set to use clipboard manager for copy "+y 
" for paste "+p
set clipboard+=unnamedplus

" TODO add someplugin or config to show the signature func while completing
" the params
" plugin manager
call plug#begin('~/.config/nvim/plugged')

	" color theme
	Plug 'olimorris/onedarkpro.nvim'

	"color previews
	Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

	" general plugins
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'preservim/nerdtree'
	Plug 'tpope/vim-surround'
	Plug 'mg979/vim-visual-multi'
	Plug 'jiangmiao/auto-pairs'
	Plug 'mbbill/undotree'
	Plug 'tpope/vim-commentary' " TODO comment.nvim gave a chance
	Plug 'tpope/vim-repeat'

	" git 
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	" Neovim LSP
	Plug 'neovim/nvim-lspconfig'

	" plugins using treesitter power
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
	Plug 'p00f/nvim-ts-rainbow'
	Plug 'windwp/nvim-ts-autotag'
	Plug 'JoosepAlviste/nvim-ts-context-commentstring'
	Plug 'lukas-reineke/indent-blankline.nvim'
	"Plug 'nvim-treesitter/playground'

	" Autocompletion
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'ray-x/lsp_signature.nvim'
	" For vsnip users.
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'
	Plug 'rafamadriz/friendly-snippets'

	" Telescope
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

	" Javascript Typescript
	Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
	" Plug 'dense-analysis/ale'
	Plug 'jose-elias-alvarez/null-ls.nvim'

	" Markdown
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }	

call plug#end()

" vim vim-visual-multi
let g:VM_mouse_mappings = 1

" vim'gitguitter configure
let g:gitgutter_terminal_reports_focus=0
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

" autoclose tag configure
let g:closetag_xhtml_filenames = '*.jsx, *.js'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" mapleader to space
let mapleader = " "

" remap for save save w
nnoremap <Leader>s :w<CR>
" autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

" remap nerdtree
let NERDTreeShowHidden=1
nnoremap <Leader>n :NERDTreeFocus<CR>

" remap for move faster between buffers
" https://stackoverflow.com/questions/5559029/quickly-switching-buffers-in-vim-normal-mode
map <silent> gn :bn<cr>
map <silent> gp :bp<cr>
map <silent> <leader>d :bd<cr>


" remap remove hightlight with esc
map <silent> <esc> :noh<cr>

" markdown-preview remap & config
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle
let g:mkdp_auto_close = 0
" ------------------------------------------------

if (has("termguicolors"))
	set termguicolors
endif

" this keep the terminal background set up
"highlight Normal guibg=none

" configure ale plugin
" https://github.com/dense-analysis/ale
" let g:ale_fixers = {
" 			\ 'javascript': ['eslint'],
" 			\ 'typescript': ['eslint'],
" 			\ 'typescriptreact': ['eslint'],
" 			\ 'javascriptreact': ['eslint'],
" 			\}

" let g:ale_sign_error = 'x'
" let g:ale_sign_warning = '!'
" let g:ale_fix_on_save = 1 " change the message ale_echo_msg_format https://github.com/dense-analysis/ale#5ix-how-can-i-change-the-format-for-echo-messages
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_open_list = 0
" nmap <silent> <leader>an <Plug>(ale_next_wrap)
" nmap <silent> <M-up> <Plug>(ale_previous_wrap)
" ------------------------------------

" config vim-hexokinase 
let g:Hexokinase_highlighters = ['sign_column']
let g:Hexokinase_optInPatterns = 'full_hex, rgb, rgba, hsl, hsla, colour_names'
" ------------------------------------

" config bash-language-server
let g:LanguageClient_serverCommands = {
	\ 'sh': ['bash-language-server', 'start'],
	\ 'zsh': ['bash-language-server', 'start'] 
	\}
" ------------------------------------

" source one dark config
source ~/.config/nvim/onedark-config.vim

" source telescope keymaps and config
source ~/.config/nvim/telescope.vim

" cmp config lua
":luafile ~/.config/nvim/cmp.lua 
source ~/.config/nvim/cmp-config.vim

" nvim null-ls config
" source ~/.config/nvim/null-ls.vim

" Lualine config 
source ~/.config/nvim/lualine-config.vim

" nvim-treesitter config file
source ~/.config/nvim/treesitter-config.vim

" nvim-indent-blankline
source ~/.config/nvim/indent-blankline-config.vim

" LSP configuration
source ~/.config/nvim/lsp-config.vim

" lsp signature config
source ~/.config/nvim/lsp-signature-config.vim
"
"
""" ------------------------------------
