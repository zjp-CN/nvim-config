local bind = require 'keymap'.bind

bind('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
bind('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
bind('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
bind('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
bind('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
bind('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])
bind('n', '<Leader>l', ':noh<CR>')
