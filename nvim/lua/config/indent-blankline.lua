local indent_blankline_status_ok, indent_blankline = pcall(require, "ibl")
if not indent_blankline_status_ok then
	return
end

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

indent_blankline.setup()
