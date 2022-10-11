local bind = require 'keymap'.bind
local autocmd = vim.api.nvim_create_autocmd

-- rust.vim 是内置的
-- g.rustfmt_autosave = 1

vim.cmd [[
set foldenable
" quickfix
compiler cargo
" bacon
set nowritebackup
set noequalalways
]]

bind('n', '<leader>ct', ":RustOpenCargo<CR>")
bind('n', '<F6>', ":RustExpandMacro<CR>")
bind('n', '<F5>', ":RustHoverActions<CR>")

if vim.g.no_fmt then
  return nil
end
autocmd('BufWritePre', {
  pattern = '*.rs',
  command = ':lua vim.lsp.buf.format()',
})
