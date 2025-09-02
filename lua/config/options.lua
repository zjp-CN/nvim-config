-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- exchange default leader/localleader set by lazyvim
vim.g.mapleader = [[\]]
vim.g.localleader = [[<space>]]
vim.g.lazyvim_picker = "telescope"

vim.opt.conceallevel = 0 -- no hidden symbols especially in markdown
vim.opt.clipboard = "" -- disable sync with system clipboard

local border = "double"

-- vim.lsp.buf.hover({ border })
-- vim.lsp.buf.signature_help({ border })
vim.diagnostic.config({ float = { border } })
