-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- exchange default leader/localleader set by lazyvim
vim.g.mapleader = [[\]]
vim.g.localleader = [[<space>]]
vim.g.lazyvim_picker = "telescope"

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.conceallevel = 0 -- no hidden symbols especially in markdown
vim.opt.clipboard = "unnamedplus" -- set this to '' to disable sync with system clipboard

-- enable undotree and map the key to open
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<space>u", require("undotree").open)

-- Restore jumping to next/previous diff location in diff mode. (TreeSitter overrides them.)
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    if vim.v.option_new == "true" or vim.wo.diff then
      vim.keymap.set("n", "]c", "]c", { buffer = true, desc = "Next diff location" })
      vim.keymap.set("n", "[c", "[c", { buffer = true, desc = "Previous diff location" })
    end
  end,
})

local border = "double"

-- vim.lsp.buf.hover({ border })
-- vim.lsp.buf.signature_help({ border })
vim.diagnostic.config({ float = { border } })

-- **************** safety-tool LSP config ****************
vim.lsp.config["safety-lsp"] = {
  -- Command and arguments to start the server.
  cmd = { "/home/gh-zjp-CN/tag-std/safety-tool/target/debug/safety-lsp" },
  -- Environment variables passed to the LSP process on spawn
  cmd_env = {
    SP_DISABLE_CHECK = 1,
    -- SP_FILE = "/home/gh-zjp-CN/tag-std/safety-tool/assets/sp-core.toml",
  },

  -- Filetypes to automatically attach to.
  filetypes = { "rust" },

  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { "Cargo.toml" }, ".git" },

  -- Specific settings to send to the server. The schema is server-defined.
  settings = {},
}
-- Make LSP server config into effects.
-- vim.lsp.enable("safety-lsp")
