local tele = require 'telescope'
local action = require 'telescope.actions'
local keymap = require 'keymap'
local bind = keymap.bind

-- :h telescope.actions
local mappings = {
  i = {
    -- 上翻/下翻历史搜索记录：所有功能共享历史搜索记录
    ["<C-Down>"] = action.cycle_history_next,
    ["<C-Up>"] = action.cycle_history_prev,
  },
  n = {
    ["t"] = action.toggle_all, -- 反选所有
    ["T"] = action.drop_all, -- 取消所有
    ["d"] = action.delete_buffer,
  }
}

tele.setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { vertical = { width = 0.95, height = 0.95, prompt_position = 'top' } },
    mappings = mappings,
  },
  extensions = {
    ['ui-select'] = {
      require 'telescope.themes'.get_dropdown {},
      file_browser = { theme = 'ivy', hijack_netrw = true, },
    }
  },
}
tele.load_extension 'ui-select'
tele.load_extension 'file_browser'

-- general keymap
bind('n', ',l', ':Telescope live_grep<CR>')
bind('n', ',g', ':Telescope grep_string<CR>')
bind('n', ',f', ':Telescope find_files<CR>')
bind('n', ',F', ':Telescope oldfiles<CR>')
bind('n', ',h', ':Telescope highlights<CR>')
bind('n', ',k', ':Telescope keymaps<CR>')
bind('n', ',b', ':Telescope buffers<CR>')

-- LSP only keymap
keymap.autocmd('LSPTelescopeKeybindings',
  function()
    bind('n', ',d', ':Telescope diagnostics<CR>')
    bind('n', ',D', ':Telescope lsp_document_symbols<CR>')
    bind('n', ',S', ':Telescope lsp_workspace_symbols<CR>')
    bind('n', ',s', ':Telescope lsp_dynamic_workspace_symbols<CR>')
    bind('n', ',i', ':Telescope lsp_incoming_calls<CR>')
    bind('n', ',o', ':Telescope lsp_outgoing_calls<CR>')
    bind('n', ',t', ':Telescope lsp_type_definitions<CR>')
    bind('n', ',T', ':Telescope lsp_implementations<CR>')
  end
)
