local nvim_dap_virtual_text_status_ok, nvim_dap_virtual_text = pcall(require, "nvim_dap_virtual_text");

if not nvim_dap_virtual_text_status_ok then
  return
end

nvim_dap_virtual_text.setup();
