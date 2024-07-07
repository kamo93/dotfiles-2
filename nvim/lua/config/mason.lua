local mason_status_ok, mason = pcall(require, "mason")
local mason_lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_status_ok and mason_lsp_status_ok then
  return
end


mason.setup()
mason_lsp.setup {
  ensure_installed = {
    'vimls',
    'jsonls',
    'tsserver',
    'eslint',
    'bashls',
    'html',
    'lua_ls',
    'tailwindcss',
    'terraformls',
    'prismals',
  },
}
