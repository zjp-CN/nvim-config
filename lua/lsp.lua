-- 1. run `nvim --cmd ":let g:no_lsp=1"` to disable lsp
-- 2. disabled for lua files (use `:LspStar` to enable)
if vim.g.no_lsp then
  return {}
end

local M = {}
local nvim_lsp = require 'lspconfig'
M.capabilities = require 'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- 回调
M.on_attach = function(_, bufnr)
  local doautocmd = vim.api.nvim_exec_autocmds
  local keygroup = require 'keymap'.augroup

  -- lua/keymap.lua
  doautocmd('User', { pattern = 'LSPKeybindings', group = keygroup })
  doautocmd('User', { pattern = 'LSPSageKeybindings', group = keygroup })
  doautocmd('User', { pattern = 'LSPTelescopeKeybindings', group = keygroup })

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

nvim_lsp.lua_ls.setup {
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
require 'rust-tools'.setup {
  tools = {
    inlay_hints = {
      auto = false,
      show_parameter_hints = true,
      right_align = false,
      parameter_hints_prefix = '// <-',
      other_hints_prefix = '// ',
      highlight = 'CocInlayHint',
    },
  },
  server = {
    on_attach = M.on_attach,
    flags = { debounce_text_changes = 150, },
    capabilities = M.capabilities,
    settings = { ['rust-analyzer'] = rust.user_ra_config, },
    standalone = false, -- :RustStartStandaloneServerForBuffer for manually enabling
    -- handlers = {
    --   ["textDocument/publishDiagnostics"] = vim.lsp.with(
    --     vim.lsp.diagnostic.on_publish_diagnostics, {
    --     -- Disable a feature
    --     update_in_insert = true,
    --   })
    -- }
  },
}

-- npm i -g vscode-langservers-extracted
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.deepcopy(M.capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- html lsp
nvim_lsp.html.setup { capabilities = capabilities, on_attach = M.on_attach}
-- css lsp
nvim_lsp.cssls.setup { capabilities = capabilities, on_attach = M.on_attach}
-- json lsp
nvim_lsp.jsonls.setup { capabilities = capabilities, on_attach = M.on_attach}
-- typescript / javascript lsp: not support format on save, doc hovering etc
-- nvim_lsp.eslint.setup({
--   --- ...
--   on_attach = function(client, bufnr)
--     M.on_attach()
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = bufnr,
--       command = "EslintFixAll",
--     })
--   end,
--   capabilities = capabilities,
-- })
-- typescript / javascript lsp: npm install -g svelte-language-server
nvim_lsp.tsserver.setup {}
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.html', '*.css', '*.js', '*.ts', '*.json' },
  command = ':lua vim.lsp.buf.format()',
})


-- https://github.com/artempyanykh/marksman
nvim_lsp.marksman.setup {}

return M
