local tele = require 'telescope'
local action = require 'telescope.actions'
local layout = require "telescope.actions.layout"
local keymap = require 'keymap'
local bind = keymap.bind

tele.load_extension 'aerial'
tele.load_extension 'ui-select'
tele.load_extension 'file_browser'
tele.load_extension 'frecency'
tele.load_extension 'smart_history'
tele.load_extension 'persisted'

-- :h telescope.actions
-- to_fuzzy_refine 的用法是先 exact search，然后对其结果 fuzzy search
local mappings = {
  i = { -- insert mode
    -- 上翻/下翻历史搜索记录：所有功能共享历史搜索记录
    ["<C-Down>"] = action.cycle_history_next,
    ["<C-Up>"] = action.cycle_history_prev,
    ["<C-f>"] = action.to_fuzzy_refine, -- fuzzy search in live_grep
  },
  n = { -- normal mode
    ["t"] = action.toggle_all, -- 反选所有
    ["T"] = action.drop_all, -- 取消所有
    ["d"] = action.delete_buffer,
    -- `<C-q>` clear + send all to quickfix
    -- `<A-q>` clear + send the selected to quickfix
    -- `a` add the selected to quickfix
    -- `A` add all to quickfix
    ["M-a"] = action.add_selected_to_qflist,
    ["C-A"] = action.add_to_qflist,
    ["l"] = layout.cycle_layout_next,
    ["p"] = layout.toggle_preview,
    ["<C-f>"] = action.to_fuzzy_refine, -- fuzzy search in live_grep
  }
}

tele.setup {
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      vertical = { width = 0.99, height = 0.95, prompt_position = 'top' },
      horizontal = { width = 0.99, height = 0.95, prompt_position = 'bottom', preview_cutoff = 10 },
    },
    mappings = mappings,
    history = { path = vim.fn.stdpath 'data' .. '/telescope_history.sqlite3', limit = 100, } -- telescope-smart-history.nvim
  },
  extensions = {
    ['ui-select'] = { require 'telescope.themes'.get_dropdown {}, },
    -- file_browser = { theme = 'ivy', hijack_netrw = true, },
    aerial = {
      -- Display symbols as <root>.<parent>.<symbol>
      show_nesting = {
        ['_'] = false, -- This key will be the default
        json = true, -- You can set the option for specific filetypes
        yaml = true,
      }
    }
  },
}

-- general keymap: builtin
bind('n', ',l', ':Telescope live_grep<CR>')
bind('n', ',g', ':Telescope grep_string<CR>')
bind('n', ',f', ':Telescope find_files<CR>')
bind('n', ',F', ':Telescope find_files no_ignore=true<CR>')
bind('n', ',h', ':Telescope highlights<CR>')
bind('n', ',H', ':Telescope help_tags<CR>')
bind('n', ',k', ':Telescope keymaps<CR>')
bind('n', ',b', ':Telescope buffers<CR>')
bind('n', ',B', ':Telescope current_buffer_fuzzy_find<CR>')
bind('n', ',q', ':Telescope quickfix<CR>')
bind('n', ',Q', ':Telescope quickfixhistory<CR>')
bind('n', ',x', ':Telescope commands<CR>')

-- need extra plugins
bind('n', ',C', ':Telescope frecency<CR>')
bind('n', ',c', ':Telescope frecency workspace=CWD<CR>')
bind('n', '<space>f', ':Telescope file_browser<CR>')
bind('n', '<space>F', ':lua require"telescope".extensions.file_browser.file_browser{path=vim.fn.expand"%:p:h"}<CR>')
bind('n', ';f', ':Telescope file_browser respect_gitignore=false<CR>')
bind('n', ';F',
  ':lua require"telescope".extensions.file_browser.file_browser{path=vim.fn.expand"%:p:h", respect_gitignore=false}<CR>')
bind('n', '<space>S', ':Telescope persisted<CR>')

-- LSP only keymap
keymap.autocmd('LSPTelescopeKeybindings',
  function()
    bind('n', ',d', ':Telescope diagnostics layout_strategy=vertical<CR>')
    bind('n', ',D', ':Telescope lsp_document_symbols<CR>')
    bind('n', ',s', ':Telescope lsp_workspace_symbols<CR>')
    -- bind('n', ',S', ':Telescope lsp_dynamic_workspace_symbols<CR>')
    bind('n', ',i', ':Telescope lsp_incoming_calls<CR>')
    bind('n', ',o', ':Telescope lsp_outgoing_calls<CR>')
    bind('n', ',t', ':Telescope lsp_type_definitions<CR>')
    bind('n', ',T', ':Telescope lsp_implementations<CR>')
  end
)
