-- Enable GDB debugger, and some settings on it.
if vim.fn.exists(":Termdebug") == 0 then
  local ok, _ = pcall(vim.api.nvim_command, "packadd termdebug")
  if not ok then
    return
  end
end

-- Highlight the current line and breakpoints.
local function debugPCHighlighted()
  vim.api.nvim_set_hl(0, "debugPC", { bg = "darkred", fg = "white" })
  vim.api.nvim_set_hl(0, "debugBreakpoint", { bg = "red", fg = "white" })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "darkyellow", bg = "none", bold = true })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#192753" })
end
debugPCHighlighted()
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", callback = debugPCHighlighted })

-- Replace gdb with the rust wrapper.
vim.g.termdebugger = "rust-gdb"

-- Left-to-right split.
vim.g.termdebug_wide = 1

-- Helper function to set keymap in normal mode.
local bind = function(key, cmd, desc)
  vim.keymap.set("n", key, cmd, { silent = true, desc = desc })
end

-- **************** Shortcuts. ****************
local function set_debug_keys()
  -- Run GDB.
  bind("<F4>", ":Continue<CR>", "Debug: Continue")
  bind("<F5>", ":Over<CR>", "Debug: Over (Next line)")
  bind("<F8>", ":Finish<CR>", "Debug: Finish (Run to End of the function)")
  bind("<F9>", ":Step<CR>", "Debug: Step (Step in)")
  bind("<leader>dS", ":Stop<CR>", "Debug: Stop (Exit the program)")

  -- Breakpoints.
  bind("<leader>db", ":Break<CR>", "Debug: Break (Set a breakpoint at current line)")
  bind("<leader>dc", ":Clear<CR>", "Debug: Clear (Unset the breakpoint at current line)")

  -- Fouce on pane.
  bind("<leader>da", ":Asm<CR>", "Debug: Open/Jump to Asm")
  bind("<leader>dv", ":Var<CR>", "Debug: Open/Jump to Var")
  bind("<leader>dm", ":Program<CR>", "Debug: Open/Jump to Program")
  bind("<leader>ds", ":Source<CR>", "Debug: Open/Jump to Source")
  bind("<leader>dg", ":Gdb<CR>", "Debug: Open/Jump to GDB")

  -- Send and execute commands in GDB pane, using leader key.
  local function send_gdb_cmd(key, cmd, desc)
    bind("<leader>" .. key, function()
      vim.fn.TermDebugSendCommand(cmd)
    end, desc)
  end
  send_gdb_cmd("de", "source entry.gdb", "Debug: source entry.gdb")
  send_gdb_cmd("dw", "where", "Debug: where (i.e. bt/info stack)")
  send_gdb_cmd("dW", "bt full", "Debug: bt with locals")
  send_gdb_cmd("di", "info inferiors", "Debug: info inferiors")
  send_gdb_cmd("dB", "info breakpoints", "Debug: info breakpoints")
  send_gdb_cmd("dl", "info locals", "Debug: info locals")
  send_gdb_cmd("dd", "dash -enabled off", "Debug: disable dashboard")
  send_gdb_cmd("dD", "dash -enabled on", "Debug: enable dashboard")
  send_gdb_cmd("dq", "shell clear", "Debug: shell clear")
end

-- 定义一个函数来删除快捷键
local function del_debug_keys()
  local keys = {
    "<F4>",
    "<F5>",
    "<F8>",
    "<F9>",
    "<leader>dS",
    "<leader>db",
    "<leader>dc",
    "<leader>da",
    "<leader>dv",
    "<leader>dm",
    "<leader>ds",
    "<leader>dg",
    "<leader>de",
    "<leader>dw",
    "<leader>dW",
    "<leader>di",
    "<leader>dB",
    "<leader>dl",
    "<leader>dd",
    "<leader>dD",
    "<leader>dq",
    "<leader>dd",
    "<leader>dd",
  }
  for _, key in ipairs(keys) do
    pcall(vim.keymap.del, "n", key)
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "TermdebugStartPost",
  callback = set_debug_keys,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "TermdebugStopPost",
  callback = del_debug_keys,
})

vim.keymap.set("n", "<leader>d ", function()
  -- Helper function to simulate keypresses and trigger existing mappings (remap)
  local function press_key(keys)
    local termcodes = vim.api.nvim_replace_termcodes(keys, true, false, true)
    -- The "m" flag ensures that Neovim recognizes and executes existing user mappings
    vim.api.nvim_feedkeys(termcodes, "m", true)
  end

  -- Step 1: Execute the <leader>rl mapping (e.g., your build or clean logic)
  press_key("<leader>rl")

  -- Delay the next step slightly to ensure <leader>rl has started
  vim.defer_fn(function()
    -- Step 2: Launch the Termdebug session
    vim.cmd("Termdebug")

    -- Step 3: Execute the <leader>ds mapping (e.g., source entry.gdb)
    -- IMPORTANT: GDB needs time to initialize buffers and the terminal process.
    -- If 'entry.gdb' fails to load, increase this 500ms delay to 800ms or 1000ms.
    vim.defer_fn(function()
      press_key("<leader>de")
      vim.notify("Start miri test: rl -> Termdebug -> de", vim.log.levels.INFO)
    end, 500)
  end, 100)
end, { desc = "Debug: start kmiri test" })
