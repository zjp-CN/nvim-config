require('neogen').setup({ snippet_engine = "luasnip" })

require 'keymap'.bind("i", "<C-g>", "<c-o>:lua require('neogen').generate()<CR>")
