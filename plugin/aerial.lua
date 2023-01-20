require 'aerial'.setup {
  layout = {
    -- default_direction = "float",
    placement = "edge",
    min_width = { 40, 0.4 },
  },
  nerd_font = false,
  close_on_select = true,
  show_guides = true,
  float = {
    relative = "win",
    min_height = { 8, 0.5 },
  },
  backends = { "lsp", "treesitter", "markdown", "man" },
  filter_kind = false,
}

local bind = require 'keymap'.bind
bind('n', '<space>t', ':AerialToggle<CR>')
-- bind('n', '<space>T', ':call aerial#fzf()<CR>')
bind('n', '<space>T', ':Telescope aerial<CR>')
