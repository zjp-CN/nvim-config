-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt = vim.opt
-- trailing spaces are shown as ⋅
opt.listchars:append("trail:⋅")

-- don't yank contents to system clipborad,
-- when system clipborad needs yank, use `+` register (i.e. `"+y`)
opt.clipboard = ""

vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true })

vim.api.nvim_create_autocmd({
  "BufNewFile",
  "BufRead",
}, {
  pattern = "*.typ",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(buf, "filetype", "typst")
    -- vim.api.nvim_set_option_value("filetype", "typst", { buf })
  end,
})
