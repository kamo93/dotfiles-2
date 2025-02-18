local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {"typescript", "tsx", "c", "lua", "query", "vimdoc", "luadoc"},
  auto_install = true,
  sync_install = true,
  ignore_install = {},
  modules = {},
  highlight = {
    enable = true,
    disable = function (lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { "yaml" }
  },
  -- comment this sice now rainbow works on tsx files and jsx looks 🤮
  -- rainbow = {
  -- 	enable = false,
  -- 	extended_mode = true,
  -- 	max_file_lines = nil
  -- },
  autotag = {
    enable = true
  },
  -- context_commentstring = {
  -- 	enable = true,
  -- 	config = {
  -- javascript = {
  -- __default = '// %s',
  -- jsx_element = '{/* %s */}',
  -- jsx_fragment = '{/* %s */}',
  -- jsx_attribute = '// %s',
  -- comment = '// %s'
  -- 		}
  -- 	}
  -- },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

