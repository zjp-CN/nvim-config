local saga = require 'lspsaga'

saga.init_lsp_saga {
  diagnostic_header = { 'E', 'W', 'I', 'H' },
  code_action_icon = '',
  max_preview_lines = 30, -- preview lines of lsp_finder and definition preview
  finder_action_keys = {
    open = '<CR>', vsplit = 's', split = 'i', quit = '<Esc>', scroll_down = '<C-f>', scroll_up = '<C-b>'
  },
  code_action_keys = { quit = "<Esc>", exec = "<CR>" },
  rename_action_quit = '<Esc>',
  definition_preview_icon = ''
}
