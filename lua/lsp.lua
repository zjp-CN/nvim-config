local M = {}
local nvim_lsp = require 'lspconfig'
M.capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- 回调
M.on_attach = function(_, bufnr)
  local doautocmd = vim.api.nvim_exec_autocmds
  local keygroup = require 'keymap'.augroup

  -- lua/keymap.lua
  doautocmd('User', { pattern = 'LSPKeybindings', group = keygroup })
  doautocmd('User', { pattern = 'LSPSageKeybindings', group = keygroup })

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', },
      diagnostics = { globals = { 'vim' }, },
      workspace = { library = vim.api.nvim_get_runtime_file('', true), },
      telemetry = { enable = false, },
    },
  },
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

local rust = require("lsp.rust")
local extension_path = '/rust/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
require 'rust-tools'.setup {
  tools = {
    autoSetHints = false,
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = '// <-',
      other_hints_prefix = '// ',
      highlight = 'InlayHint',
      auto = false,
    },
  },
  server = {
    on_attach = M.on_attach,
    flags = { debounce_text_changes = 150, },
    capabilities = M.capabilities,
    settings = { ['rust-analyzer'] = rust.user_ra_config, },
    standalone = true,
  },
  dap = {
    adapter = require 'rust-tools.dap'.get_codelldb_adapter(
      codelldb_path, liblldb_path)
  },
  runnables = { use_telescope = true, },
  debuggables = { use_telescope = true, },
}

return M
