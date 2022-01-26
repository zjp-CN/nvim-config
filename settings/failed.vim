
" === lsp-status.nvim ==
" lua << END
" local lsp_status = require('lsp-status')
" lsp_status.register_progress()
" lsp_status.config({
"   indicator_errors = 'E',
"   indicator_warnings = 'W',
"   indicator_info = 'i',
"   indicator_hint = '?',
"   indicator_ok = 'Ok',
" })
" 
" lsp_status.extensions = {'rust_analyzer'}
" --local lspconfig = require('lspconfig')
" 
" -- Some arbitrary servers
" --lspconfig.rust_analyzer.setup({
" --  on_attach = lsp_status.on_attach,
" --  capabilities = lsp_status.capabilities
" --})
" END
" 
" " Statusline
" function! LspStatus() abort
"   if luaeval('#vim.lsp.buf_get_clients() > 0')
"     return luaeval("require('lsp-status').status()")
"   endif
" 
"   return ''
" endfunction
