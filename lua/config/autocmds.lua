-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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

vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true })

-- TextChanged
-- vim.api.nvim_create_autocmd({ "change" }, {
--   -- vim.api.nvim_create_autocmd({ "CompleteChanged", "TextChangedP", "FileWritePost" }, {
--   group = "___cmp___",
--   callback = function(ev)
--     print("change")
--     -- print(string.format("event fired: %s", vim.inspect(ev)))
--     local cmp = require("cmp")
--     local entries = cmp.get_entries()
--     if #entries ~= 0 then
--       local f = io.open("completion.log", "a+")
--       print("CompleteChanged")
--       f:write(vim.inspect(entries))
--       f:write(vim.inspect(ev))
--     end
--     -- f:write("\nend\n")
--   end,
-- })
-- nvim_create_autocmd

require("cmp_lsp_rs").log.register()

-- vim.api.nvim_create_autocmd({ "User" }, {
--   pattern = "CmpReady",
--   callback = function()
--     local f = io.open("completion.log", "w")
--     f:write("CmpReady")
--   end,
-- })

-- cmp.event:on("menu_opened", function()
--   ---@type  cmp.Entry[]
--   local entries = cmp.get_entries()
--   -- print("menu_opened", "entries count: ", #entries)
--   -- if #entries < 2 then
--   local f = io.open("completion.log", "w")
--   if not f then
--     return
--   end
--   f:write("\nmenu_opened\n")
--   -- for _, entry in ipairs(entries) do
--   local entry = entries[1]
--   if entry then
--     f:write(vim.inspect(entry.completion_item))
--   end
--   local entry = entries[2]
--   if entry then
--     f:write(vim.inspect(entry.completion_item))
--   end
--   -- end
--   -- f:write(vim.inspect(entries))
--   -- f:write(vim.inspect(ev))
--   -- end
-- end)
