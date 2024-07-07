local dap_status_ok, dap = pcall(require, "dap")

if not dap_status_ok then
  return
end

dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

local keymapDefaultOpts = { silent = true };

vim.keymap.set('n', "<F5>", function ()
  dap.continue()
end, keymapDefaultOpts)
vim.keymap.set('n', "<F10>", function ()
  dap.step_over()
end, keymapDefaultOpts)
vim.keymap.set('n', "<F11>", function ()
  dap.step_into()
end, keymapDefaultOpts)
vim.keymap.set('n', "<F12>", function ()
  dap.step_out()
end, keymapDefaultOpts)
vim.keymap.set('n', "<leader>b", function ()
  dap.toggle_breakpoint()
end, keymapDefaultOpts)
vim.keymap.set('n', "<leader>B", function ()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, keymapDefaultOpts)
vim.keymap.set('n', "<leader>lp", function ()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, keymapDefaultOpts)
vim.keymap.set('n', "<Leader>dr", function ()
  dap.repl.open()
end, keymapDefaultOpts)
vim.keymap.set('n', "<Leader>dl", function ()
  dap.run_last()
end, keymapDefaultOpts)
