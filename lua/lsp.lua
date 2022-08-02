local M = {}
local nvim_lsp = require 'lspconfig'
local capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- 解析 Json 配置文件
M.json_file = function(path)
  local file = io.open(path, 'rb')
  if not file then return {} end
  local content = file:read('*a')
  file:close()
  return vim.json.decode(content) or {}
end

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
  capabilities = capabilities,
}

local config_home = os.getenv('XDG_CONFIG_HOME') or (os.getenv('HOME') .. '/.config')
local user_ra_config = M.json_file(config_home .. '/nvim/rust-analyzer.json')
local extension_path = '/rust/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
require 'rust-tools'.setup {
  tools = {
    autoSetHints = false,
    hover_with_actions = true,
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
    capabilities = capabilities,
    settings = { ['rust-analyzer'] = user_ra_config, },
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
