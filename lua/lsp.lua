local M = {}
local nvim_lsp = require 'lspconfig'
local capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- 解析 Json 配置文件
M.json_file = function(path)
  local file = io.open(path, 'rb')
  if not file then return nil end
  local content = file:read('*a')
  file:close()
  return vim.json.decode(content) or nil
end

-- table.is_empty
local function is_empty_table(t)
  return rawequal(next(t), nil)
end

-- 当前目录及其上级目录
-- path: "/tmp/nvim.root/uxwsBf/2_Luapad.lua"
-- paths: { "/tmp/nvim.root/uxwsBf/", "/tmp/nvim.root/", "/tmp/", "/" }
local function recur_dir(path)
  local split_path, paths = { '' }, {}
  for s in string.gmatch(path, '([^/]+)') do table.insert(split_path, s) end
  while not is_empty_table(split_path) do
    table.insert(paths, table.concat(split_path, '/') .. '/')
    table.remove(split_path)
  end
  return paths
end

-- 查找工作目录及其上级目录下的 ./settings/rust-analyzer.json 文件
local function settings_ra_config()
  local search_dirs = recur_dir(vim.fn.getcwd())
  for _, dir in ipairs(search_dirs) do
    local path = dir .. ".settings/" .. M.ra_json
    local user_ra_config_override = M.json_file(path)
    -- print(path, user_ra_config_override)
    if user_ra_config_override then
      return user_ra_config_override
    end
  end
  return nil
end

M.ra_json = 'rust-analyzer.json'

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

-- 如果项目目录中有 `.settings/rust-analyzer.json` 文件，则直接使用
local user_ra_config_override = settings_ra_config()
if user_ra_config_override then
  M.user_ra_config = user_ra_config_override
else
  -- 如果项目目录中有 `rust-analyzer.json` 文件，则优先使用（合并 nvim 下的配置）
  local config_home = os.getenv('XDG_CONFIG_HOME') or (os.getenv('HOME') .. '/.config')
  M.user_ra_config = M.json_file(config_home .. '/nvim/' .. M.ra_json) or {}
  local user_ra_config = M.json_file(M.ra_json) or {}
  for key, value in pairs(user_ra_config) do
    M.user_ra_config[key] = value
  end
end
-- print(vim.inspect(M.user_ra_config))

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
    capabilities = capabilities,
    settings = { ['rust-analyzer'] = M.user_ra_config, },
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
