local colorizer_ok, colorizer = pcall(require, "colorizer")
if not colorizer_ok then
	return
end

colorizer.setup({
  filetypes = {
    'css',
    'javascript',
    typescript,
    'javascriptreact',
    typescriptreact,
    html = { names = false }
  },
  user_default_options = { lowercase = true }

})
