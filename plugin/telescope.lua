local tele = require 'telescope'
tele.setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { vertical = { width = 0.95, height = 0.95, prompt_position = 'top' } },
  },
  extensions = {
    ['ui-select'] = {
      require 'telescope.themes'.get_dropdown {},
      file_browser = { theme = 'ivy', hijack_netrw = true, },
    }
  }
}
tele.load_extension 'ui-select'
tele.load_extension 'file_browser'
