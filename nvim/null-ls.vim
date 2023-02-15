lua << EOF
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		formatting.eslint,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
				vim.cmd([[
				augroup LspFormatting
						autocmd! * <buffer>
						autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
				augroup END
				]])
		end
	end,
})
EOF
