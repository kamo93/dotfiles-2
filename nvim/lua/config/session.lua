local M = {}

local sessions_dir = vim.fn.stdpath("data") .. "/sessions"
local timer = nil
local current_session_file = nil

-- Ensure sessions directory exists
local function ensure_dir()
  vim.fn.mkdir(sessions_dir, "p")
end

-- Encode cwd path to a safe filename: /Users/kamo/code/proj -> %Users%kamo%code%proj.vim
local function encode_path(path)
  return path:gsub("/", "%%") .. ".vim"
end

-- Decode filename back to path
local function decode_path(filename)
  return filename:gsub("%.vim$", ""):gsub("%%", "/")
end

-- Get the short project name from a decoded path (last directory component)
local function project_name(decoded)
  return decoded:match("([^/]+)$") or decoded
end

-- Stop any running auto-save timer
local function stop_timer()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
end

-- Save session to file (silent, used by both manual and auto-save)
local function write_session(file)
  vim.cmd("mksession! " .. vim.fn.fnameescape(file))
end

-- Start auto-save timer (every 5 minutes)
local function start_autosave(file)
  stop_timer()
  current_session_file = file
  timer = vim.uv.new_timer()
  timer:start(300000, 300000, vim.schedule_wrap(function()
    if vim.fn.filereadable(file) == 1 or current_session_file == file then
      write_session(file)
    end
  end))
end

--- Save current session and start tracking
function M.save_session()
  ensure_dir()
  local cwd = vim.fn.getcwd()
  local file = sessions_dir .. "/" .. encode_path(cwd)
  write_session(file)
  start_autosave(file)
  vim.g.session_tracking = project_name(cwd)
  vim.notify("Session tracking: " .. project_name(cwd), vim.log.levels.INFO)
end

--- Load a session from file, replacing current state
function M.load_session(file)
  stop_timer()
  -- Close everything
  vim.cmd("%bdelete!")
  vim.cmd("only")
  -- Source session
  vim.cmd("source " .. vim.fn.fnameescape(file))
  -- Start tracking the loaded session
  current_session_file = file
  start_autosave(file)
  local name = project_name(decode_path(vim.fn.fnamemodify(file, ":t")))
  vim.g.session_tracking = name
  vim.notify("Session loaded: " .. name, vim.log.levels.INFO)
end

--- Telescope picker for saved sessions
function M.telescope_sessions()
  ensure_dir()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local files = vim.fn.globpath(sessions_dir, "*.vim", false, true)
  local entries = {}
  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t")
    local decoded = decode_path(filename)
    table.insert(entries, { display = project_name(decoded) .. "  " .. decoded, path = file, decoded = decoded })
  end

  if #entries == 0 then
    vim.notify("No saved sessions", vim.log.levels.WARN)
    return
  end

  pickers.new({}, {
    prompt_title = "Projects",
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display,
          ordinal = entry.decoded,
          path = entry.path,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      -- Enter: load session
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          M.load_session(selection.value.path)
        end
      end)

      -- C-d: delete session
      local function delete_session()
        local selection = action_state.get_selected_entry()
        if not selection then return end
        os.remove(selection.value.path)
        -- If we deleted the currently tracked session, stop tracking
        if current_session_file == selection.value.path then
          stop_timer()
          current_session_file = nil
          vim.g.session_tracking = nil
        end
        -- Refresh picker
        actions.close(prompt_bufnr)
        vim.schedule(function() M.telescope_sessions() end)
      end

      map("i", "<C-d>", delete_session)
      map("n", "<C-d>", delete_session)

      return true
    end,
  }):find()
end

--- Clean a specific project session by name
function M.clean(name)
  ensure_dir()
  local files = vim.fn.globpath(sessions_dir, "*.vim", false, true)
  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t")
    local decoded = decode_path(filename)
    if project_name(decoded) == name then
      os.remove(file)
      -- Stop tracking if it was the active session
      if current_session_file == file then
        stop_timer()
        current_session_file = nil
        vim.g.session_tracking = nil
      end
      vim.notify("Removed session: " .. name, vim.log.levels.INFO)
      return
    end
  end
  vim.notify("No session found for: " .. name, vim.log.levels.WARN)
end

-- Register user command with tab-completion of project names
vim.api.nvim_create_user_command("SessionClean", function(opts)
  if opts.args == "" then
    vim.notify("Usage: :SessionClean <project-name>", vim.log.levels.WARN)
    return
  end
  M.clean(opts.args)
end, {
  nargs = 1,
  desc = "Delete a saved project session by name",
  complete = function()
    local files = vim.fn.globpath(sessions_dir, "*.vim", false, true)
    local names = {}
    for _, file in ipairs(files) do
      local decoded = decode_path(vim.fn.fnamemodify(file, ":t"))
      table.insert(names, project_name(decoded))
    end
    return names
  end,
})

-- Cleanup timer on nvim exit to prevent leaks
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("SessionTimerCleanup", { clear = true }),
  callback = function()
    -- Auto-save one last time before exiting
    if current_session_file then
      write_session(current_session_file)
    end
    stop_timer()
  end,
})

return M
