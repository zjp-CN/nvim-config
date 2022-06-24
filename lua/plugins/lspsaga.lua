-- 原项目：https://github.com/glepnir/lspsaga.nvim
-- 维护版：https://github.com/tami5/lspsaga.nvim
local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = 'E',
  warn_sign = 'W',
  hint_sign = 'H',
  infor_sign = 'I',
  diagnostic_header_icon = '',
  code_action_icon = '',
  finder_definition_icon = '',
  finder_reference_icon = '',
  max_preview_lines = 30, -- preview lines of lsp_finder and definition preview
  finder_action_keys = {
    open = '<CR>', vsplit = 's', split = 'i',
    quit = '<Esc>', scroll_down = '<C-f>', scroll_up = '<C-b>'
  },
  code_action_keys = { quit = '<Esc>', exec = '<CR>' },
  rename_action_keys = { quit = '<Esc>', exec = '<CR>' },
  definition_preview_icon = ''
}
