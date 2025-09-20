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

-- **************** Custom LSP config ****************

-- Add custom LSP configuration, especially LSP server location and for what filetypes.
vim.lsp.config["nrs"] = {
  -- Command and arguments to start the server.
  cmd = { "/home/gh-zjp-CN/tmp/tower-lsp-boilerplate/target/debug/nrs-language-server" },
  -- Filetypes to automatically attach to.

  filetypes = { "nrs" },
  -- Sets the "workspace" to the directory where any of these files is found.

  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { ".nrs" }, ".git" },

  -- Specific settings to send to the server. The schema is server-defined.
  settings = {
    editor = { semanticHighlighting = { enabled = true } },
  },
}

-- Auto set up nrs filetype because neovim doesn't do it for us.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.nrs" },
  command = "set filetype=nrs",
})

-- Make LSP server config into effects.
vim.lsp.enable("nrs")
