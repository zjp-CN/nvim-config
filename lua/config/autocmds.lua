-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt = vim.opt

-- trailing spaces are shown as ⋅
opt.listchars:append("trail:⋅")

-- don't yank contents to system clipborad,
-- when system clipborad needs yank, use `+` register (i.e. `"+y`)
opt.clipboard = ""
