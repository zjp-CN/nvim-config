local g                      = vim.g
g.vista_default_executive    = 'nvim_lsp'
g.vista_icon_indent          = { "▸", "" }
g.vista_sidebar_open_cmd     = '10split'
g.vista_cursor_delay         = 250
g.vista_echo_cursor_strategy = 'floating_win'
require 'keymap'.bind('n', '<leader>v', ":Vista!!<CR>")
