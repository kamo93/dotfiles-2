-- NEED TO SET LEADER BEFORE LAZY LOAD
vim.keymap.set('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

require("config.lazy")
require("settings")
require("mappins")

-- Configs sin plugin asociado (aún por decidir): colorizer, vim-hexokinase,
-- autoclose-tag (vim-closetag) y lsp-signature.
require("config.colorizer")
require("config.vim-hexokinase")
require("config.autoclose-tag")
require("config.lsp-signature")
