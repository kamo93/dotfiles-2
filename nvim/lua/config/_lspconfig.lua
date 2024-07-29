local servers = { 
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
  -- 'csharp_ls'
  'omnisharp'
}
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local init_options = require("nvim-lsp-ts-utils").init_options
local nvim_lsp = require('lspconfig')

local function on_list_extend(options)
  local items = options.items
  local resItems = {}
  if #items > 1 then
    for _, value in ipairs(items) do
      if not string.match(value['filename'], 'styled-components') then
        table.insert(resItems, value)
      end
    end
  else
    table.insert(resItems, items[1])
  end
  vim.fn.setqflist({}, ' ', { title = options.title, items = resItems, context = options.context })
  vim.api.nvim_command('cfirst')
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', "<cmd>lua vim.diagnostic.goto_prev()<CR>zz")
vim.keymap.set('n', ']d', "<cmd>lua vim.diagnostic.goto_next()<CR>zz")
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v.:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', function()
      vim.lsp.buf.definition({ on_list = on_list_extend })
    end, { buffer = ev.buf, silent = true })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>h', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<C-T>', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end
})

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'vimls', 'jsonls', 'tsserver', 'eslint', 'bashls', 'html', 'tailwindcss' }
-- init_options.plugins = { { 
--   name = '@styled/typescript-styled-plugin',
--   location = '@styled/typescript-styled-plugin' 
-- } }
capabilities.textDocument.completion.completionItem.snippetSupport = true
for _, lsp in ipairs(servers) do
  if lsp == "tsserver" then
    nvim_lsp.tsserver.setup({
      -- Needed for inlayHints. Merge this table with your settings or copy
      -- it from the source if you want to add your own init_options.
      -- init_options = init_options,
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
      filetypes = { "sh", "zsh", "bash"},
    }
  -- elseif lsp == "eslint" then
  --   nvim_lsp.eslint.setup{
  --     capabilities = capabilities,
  --     filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro", "markdown" }
  --   }
  elseif lsp == "lua_ls" then
    nvim_lsp.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true)
          },
          telemetry = {
            -- Do not send telemetry data containing a randomized but unique identifier
            enable = false
          }
        },
      }
    }
  -- elseif lsp == "omnisharp" then
  --   nvim_lsp.omnisharp.setup {
  --     cmd = { "dotnet", "/home/kamo93/.omnisharp/OmniSharp.dll" },
  --     -- Enables support for reading code style, naming convention and analyzer
  --     -- settings from .editorconfig.
  --     enable_editorconfig_support = true,
  --
  --     -- If true, MSBuild project system will only load projects for files that
  --     -- were opened in the editor. This setting is useful for big C# codebases
  --     -- and allows for faster initialization of code navigation features only
  --     -- for projects that are relevant to code that is being edited. With this
  --     -- setting enabled OmniSharp may load fewer projects and may thus display
  --     -- incomplete reference lists for symbols.
  --     enable_ms_build_load_projects_on_demand = false,
  --
  --     -- Enables support for roslyn analyzers, code fixes and rulesets.
  --     enable_roslyn_analyzers = false,
  --
  --     -- Specifies whether 'using' directives should be grouped and sorted during
  --     -- document formatting.
  --     organize_imports_on_format = false,
  --
  --     -- Enables support for showing unimported types and unimported extension
  --     -- methods in completion lists. When committed, the appropriate using
  --     -- directive will be added at the top of the current file. This option can
  --     -- have a negative impact on initial completion responsiveness,
  --     -- particularly for the first few completion sessions after opening a
  --     -- solution.
  --     enable_import_completion = false,
  --
  --     -- Specifies whether to include preview versions of the .NET SDK when
  --     -- determining which version to use for project loading.
  --     sdk_include_prereleases = true,
  --
  --     -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
  --     -- true
  --     analyze_open_documents_only = false,
  --     filetypes = { "cs", "vb", "cshtml" }
  --   }
  else
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      sync = true,
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
    }
  end
end


vim.diagnostic.config({
  virtual_text = {
    source = "always"
  },
  float = {
    source = "always"
  },
})

-- config bash-language-server
-- vim.cmd([[
-- let g:LanguageClient_serverCommands = {
-- 	\ 'sh': ['bash-language-server', 'start'],
-- 	\ 'zsh': ['bash-language-server', 'start'] 
-- 	\}
-- ]])

-- https://github.com/hashicorp/terraform-ls/blob/main/docs/USAGE.md
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})
