require 'neogit'.setup {
  integrations = { diffview = true, }
}

local bind = require 'keymap'.bind
bind('n', '<space>n', ':Neogit<CR>')
