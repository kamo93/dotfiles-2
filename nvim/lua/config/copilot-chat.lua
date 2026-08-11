local c_copilot_status_ok, c_copilot = pcall(require, "CopilotChat")

if not c_copilot_status_ok then
  return
end

require("CopilotChat").setup({})
