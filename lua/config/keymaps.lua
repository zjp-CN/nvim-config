-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local bind = function(mode, key, cmd, desc)
  vim.keymap.set(mode, key, cmd, { silent = true, desc = desc })
end

bind("", "<F3>", ":noh<CR>", "no highlight after searching")

bind("n", "<leader>nb", ":set number! rnu!<CR>", "toggle the visibility of (relative) number")
bind("n", "<leader>NB", ":set rnu!<CR>", "toggle between relativenumber and sequence number")

-- ### buffer switching
bind("n", "<leader>dd", ":bd<CR>", "close buffer")

-- ### buffer editting
-- case switching
bind("n", "<leader>u", "vgu", "switch to lowercase under (selected) cursor")
bind("n", "<leader>U", "vgU", "switch to uppercase under (selected) cursor")
bind("v", "<leader>u", "gu", "switch to lowercase under (selected) cursor")
bind("v", "<leader>U", "gU", "switch to uppercase under (selected) cursor")
-- clear and enter
bind("n", "<leader>da", "ggVGDI", "clear the content in current buffer and enter")
-- empty line
bind("n", "[<space>", ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[", "add an empty line before the current line")
bind("n", "]<space>", ":<c-u>put =repeat(nr2char(10), v:count1)<cr>", "add an empty line after the current line")

-- floating terminal
local lazyterm = function()
  require("lazyvim.util").float_term(nil, { border = "single" })
end
bind("n", "<m-i>", lazyterm, "open float terminal")
bind("t", "<m-i>", "<cmd>close<cr>", "close (but not quit) float terminal")

-- lsp
bind("n", "<space>i", "<cmd>lua vim.lsp.inlay_hint(0)<cr>", "toggle inlay hint in current buffer")
