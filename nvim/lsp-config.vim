lua << EOF
local nvim_lsp = require('lspconfig')
local configs = require('lspconfig.configs')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'vimls', 'jsonls', 'tsserver', 'eslint', 'bashls', 'html', 'tailwindcss' }
local servers = { 'vimls', 'jsonls', 'ls_emmet', 'tsserver', 'eslint','bashls', 'html'}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local init_options = require("nvim-lsp-ts-utils").init_options
init_options.plugins = { { name = 'typescript-styled-plugin', location = 'typescript-styled-plugin' } }
capabilities.textDocument.completion.completionItem.snippetSupport = true
for _, lsp in ipairs(servers) do
	if lsp == "tsserver" then
		nvim_lsp.tsserver.setup({
			-- Needed for inlayHints. Merge this table with your settings or copy
			-- it from the source if you want to add your own init_options.
			init_options = init_options,
			capabilities = capabilities,
			--
			on_attach = function(client, bufnr)
					local ts_utils = require("nvim-lsp-ts-utils")

					-- defaults
					ts_utils.setup({
							debug = false,
							disable_commands = false,
							enable_import_on_completion = true,

							-- import all
							import_all_timeout = 5000, -- ms
							-- lower numbers = higher priority
							import_all_priorities = {
									same_file = 1, -- add to existing import statement
									local_files = 2, -- git files or files with relative path markers
									buffer_content = 3, -- loaded buffer content
									buffers = 4, -- loaded buffer names
							},
							import_all_scan_buffers = 100,
							import_all_select_source = true,
							always_organize_imports = true,

							-- filter diagnostics
							filter_out_diagnostics_by_severity = {},
							filter_out_diagnostics_by_code = {},

							-- inlay hints
							auto_inlay_hints = false,
							inlay_hints_highlight = "Comment",

							-- update imports on file move
							update_imports_on_move = false,
							require_confirmation_on_move = false,
							watch_dir = nil,
					})

					-- required to fix code action ranges and filter diagnostics
					ts_utils.setup_client(client)

					-- no default maps, so you may want to define some here
					local opts = { silent = true }
					vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
					-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>gi", ":TSLspImportAll<CR>", opts)
			end,
	})
	elseif lsp == "bashls" then
		nvim_lsp.bashls.setup {
			on_attach = on_attach,
			filetypes = { "sh", "zsh" },
			capabilities = capabilities,
		}
	else
		nvim_lsp[lsp].setup {
			on_attach = on_attach,
			capabilities = capabilities,
			sync = true,
		}
	end
end

if not configs.ls_emmet then
  configs.ls_emmet = {
    default_config = {
      cmd = { 'ls_emmet', '--stdio' };
      filetypes = {
        'html',
        'css',
        'scss',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'haml',
        'xml',
        'xsl',
        'pug',
        'slim',
        'sass',
        'stylus',
        'less',
        'sss',
        'hbs',
        'handlebars',
      };
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end
nvim_lsp.ls_emmet.setup { capabilities = capabilities }

vim.diagnostic.config({
	virtual_text = {
		source  = "always"
	},
	float = {
		source = "always"
	},
})
EOF
