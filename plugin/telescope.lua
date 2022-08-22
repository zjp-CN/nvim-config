local tele = require 'telescope'
local keymap = require 'keymap'
local bind = keymap.bind

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

-- general keymap
bind('n', ',l', ':Telescope live_grep')
bind('n', ',g', ':Telescope grep_string')
bind('n', ',f', ':Telescope find_files')

-- LSP only keymap
keymap.autocmd('LSPTelescopeKeybindings',
  function()
    bind('n', ',d', ':Telescope diagnostics')
    bind('n', ',D', ':Telescope lsp_document_symbols')
    bind('n', ',S', ':Telescope lsp_workspace_symbols')
    bind('n', ',s', ':Telescope lsp_dynamic_workspace_symbols')
    bind('n', ',i', ':Telescope lsp_incoming_calls')
    bind('n', ',o', ':Telescope lsp_outgoing_calls')
    bind('n', ',t', ':Telescope lsp_type_definitions')
    bind('n', ',T', ':Telescope lsp_implementations')
  end
)
