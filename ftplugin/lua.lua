local set = vim.opt
local autocmd = vim.api.nvim_create_autocmd

set.tabstop = 2
set.shiftwidth = 2

if vim.g.no_fmt then
  return nil
end
autocmd('BufWritePre', {
  pattern = '*.lua',
  command = ':lua vim.lsp.buf.format()',
})
