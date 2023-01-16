require 'neogit'.setup {
  integrations = { diffview = true, },
  auto_show_console = false,
  console_timeout = 10000,
}

local bind = require 'keymap'.bind
bind('n', '<space>n', ':Neogit<CR>')
