-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- load files after/ dir alphabetically
-- local dir = require("plenary.scandir").scan_dir("lua/after")
-- for i = 1, #dir do
--   require(dir[i]:gsub("\\", "/"):gsub("lua/", ""):gsub("/", "."):gsub(".lua$", ""))
-- end

local opt = vim.opt
-- trailing spaces are shown as ⋅
opt.listchars:append("trail:⋅")

-- don't yank contents to system clipborad,
-- when system clipborad needs yank, use `+` register (i.e. `"+y`)
opt.clipboard = ""

-- highlights
vim.cmd([[
  " error font color in diagnostic float window
  " error icon color on left sidebar
  hi! DiagnosticError guifg=#e86f94
  " diagnostic float window
  " hover doc float window
  hi! NormalFloat guibg=#100642

  " comments in most languages
  hi! Comment guifg=#00A000
  " but not for git
  hi! gitcommitComment guifg=grey45
  hi! gitignoreComment guifg=grey45
  hi! gitrebaseComment guifg=grey45
  hi! gitrebaseMergeComment guifg=grey45
]])
