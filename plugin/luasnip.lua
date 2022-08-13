vim.cmd [[
vnoremap <c-v>a  "ac<cmd>lua require('luasnip.extras.otf').on_the_fly()<cr>
inoremap <c-v>a  <cmd>lua require('luasnip.extras.otf').on_the_fly("a")<cr>
inoremap <c-s> <cmd>lua require("luasnip.extras.select_choice")()<cr>
snoremap <c-s> <cmd>lua require("luasnip.extras.select_choice")()<cr>
]]

require "luasnip".config.setup { store_selection_keys = "<Tab>" }
local paths = "./luasnippets"
require "luasnip.loaders.from_vscode".load { paths = paths }
require "luasnip.loaders.from_snipmate".load { paths = paths }
require "luasnip.loaders.from_lua".load { paths = paths }
