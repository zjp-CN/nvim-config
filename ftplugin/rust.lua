local g = vim.g
local bind = require 'keymap'.bind

-- rust.vim 是内置的
g.rustfmt_autosave = 1

vim.cmd [[
" quickfix
compiler cargo
" bacon
set nowritebackup
set noequalalways
]]

bind('n', '<leader>ct', ":RustOpenCargo<CR>")
