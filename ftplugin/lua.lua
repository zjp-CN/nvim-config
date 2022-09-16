local set = vim.opt
local autocmd = vim.api.nvim_create_autocmd

set.tabstop = 2
set.shiftwidth = 2

autocmd('BufWritePre', {
  pattern = '*.lua',
  command = ':lua vim.lsp.buf.format()',
})
