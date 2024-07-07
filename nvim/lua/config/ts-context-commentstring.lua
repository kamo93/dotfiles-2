-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
local ts_context_commentstring_ok, ts_context_commentstring  = pcall(require, "ts_context_commentstring")
if not ts_context_commentstring_ok then
  return
end

ts_context_commentstring.setup({
  languages = {
    javascript = {
      __default = '// %s',
      jsx_element = '{/* %s */}',
      jsx_fragment = '{/* %s */}',
      jsx_attribute = '// %s',
      comment = '// %s'
    }
  }
})
vim.g.skip_ts_context_commentstring_module = true
