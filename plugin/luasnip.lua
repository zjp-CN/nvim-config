vim.cmd [[
vnoremap <c-v>a  "ac<cmd>lua require('luasnip.extras.otf').on_the_fly()<cr>
inoremap <c-v>a  <cmd>lua require('luasnip.extras.otf').on_the_fly("a")<cr>
inoremap <c-s> <cmd>lua require("luasnip.extras.select_choice")()<cr>
snoremap <c-s> <cmd>lua require("luasnip.extras.select_choice")()<cr>
]]

local ls = require 'luasnip'
local from_vscode = require 'luasnip.loaders.from_vscode'
local from_snipmate = require 'luasnip.loaders.from_snipmate'
local from_lua = require 'luasnip.loaders.from_lua'

ls.setup({
  ft_func = require("luasnip.extras.filetype_functions").from_pos_or_filetype,
  load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
    markdown = { "lua", "rust" }
  })
})
ls.config.setup { store_selection_keys = "<Tab>" }

local paths = "./luasnippets"
from_vscode.load { paths = paths }
from_snipmate.load { paths = paths }
from_lua.load { paths = paths }

-- https://github.com/rafamadriz/friendly-snippets
from_vscode.load {
  paths = "C:\\Users\\Administrator\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\friendly-snippets",
  exclude = { "all", "global" },
}

-- extend ft: avoid copying snippets from another ft
ls.filetype_extend("NeogitCommitMessage", { "gitcommit" })

require 'keymap'.bind('n', '<space>s',
  ':lua require"luasnip.loaders".edit_snippet_files{ edit = function(file) vim.cmd("vs | e " .. file) end }<CR>')
