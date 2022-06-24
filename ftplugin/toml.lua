local bind = require 'keymap'.bind

require('cmp').setup.buffer {
  sources = {
    { name = 'crates' },
    { name = 'buffer' },
    { name = 'path' },
  }
}
bind('n', '<F5>', ":lua require('crates').show_popup()<cr>")
bind('n', '<F6>', ":lua require('crates').show_dependencies_popup()<cr>")
bind('n', '<F4>', ":lua require('crates').show_features_popup()<cr>")
