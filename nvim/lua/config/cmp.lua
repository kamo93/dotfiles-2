local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local nvim_lsp_status_ok, nvim_lsp = pcall(require, "lspconfig")
if not nvim_lsp_status_ok then
	return
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
  return
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "␂",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body)
			require('luasnip').lsp_expand(args.body)
			-- For `luasnip` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
		["<esc>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm { select = true },
		["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
		end, {
			"i",
			"s",
		}),
	["<S-Tab>"] = cmp.mapping(
		function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
			else
				fallback()
			end
		end,
		{
			"i",
			"s",
		})
  },
	formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        vsnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
	sources = {
		{ name = "nvim_lsp" },
		-- { name = "vsnip" },
		{ name = "buffer" },
		{ name = "path" },
		-- For vsnip users.
		{ name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	},
  window = {
	  documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	  },
    completion = cmp.config.window.bordered()
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  -- use this to prevent the auto-completion menu appaers automatically
  -- completion = {
  --   autocomplete = false
  -- }
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
require("luasnip.loaders.from_vscode").lazy_load()
-- luasnip.filetype_extend("typescript", { "javascript", "typescriptreact" })
-- luasnip.filetype_extend("javascript", { "javascriptreact" })


-- -- Setup lspconfig.
-- local servers = { "tsserver", "vimls", "jsonls", "eslint", "bashls", "html" }
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup {
-- 		capabilities = capabilitiies,
--   }
-- end
