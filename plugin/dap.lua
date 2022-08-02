local dap, dapui = require 'dap', require 'dapui'
local sign_define = vim.fn.sign_define
local k = require 'keymap'

sign_define('DapBreakpoint', { text = 'B', texthl = 'RedrawDebugComposed', linehl = '', numhl = '' })
sign_define('DapStopped', { text = '→', texthl = 'PmenuThumb', linehl = '', numhl = '' })

-- nvim-dap-ui
require 'dapui'.setup {
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
}

dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end

local bind = k.bind

-- nvim-dap
bind('n', '<F7>', "<Cmd>lua require'dap'.clear_breakpoints()<CR>")
bind('n', '<F8>', "<Cmd>lua require'dap'.continue()<CR>")
bind('n', '<F9>', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
bind('n', '<F12>', "<Cmd>lua require'dap'.run_to_cursor()<CR>")
bind('n', '<leader>dr', "<Cmd>lua require'dap'.repl.toggle()<CR>")
bind('n', '<leader>dc', "<Cmd>lua require'dap'.terminate()<CR>")
bind('n', '<leader>dt', "<Cmd>lua require'dapui'.toggle()<CR>")

-- Requests the debugee to step into a function or method if possible.
-- If it cannot step into a function or method it behaves like `dap.step_over()`.
bind('n', '<space>i', "<Cmd>lua require'dap'.step_into()<CR>")
-- step_next: Requests the debugee to run again for one step.
bind('n', '<space>n', "<Cmd>lua require'dap'.step_over()<CR>")
-- finish: Requests the debugee to step out of a function or method if possible.
bind('n', '<space>o', "<Cmd>lua require'dap'.step_out()<CR>")

-- nvim-dap-ui
-- For a one time expression evaluation, you can call a hover window to show a value
bind('n', '<C-k>', "<Cmd>lua require('dapui').eval()<CR>")
bind('n', '<space>k', "<cmd>lua require('dapui').float_element()<cr>")
