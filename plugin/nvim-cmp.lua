local cmp = require 'cmp'

cmp.setup {
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      -- luasnip
      require 'luasnip'.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-l>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-e>'] = cmp.mapping.complete(),
    ['<C-c>'] = cmp.mapping.close(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
  }),
  -- Installed sources
  sources = {
    -- { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'buffer', max_item_count = 15, keyword_length = 3,
      option = {
        get_bufnrs = function() return vim.api.nvim_list_bufs() end, -- search words in all buffers
        keyword_pattern = [[\k\+]], -- use the iskeyword option for recognizing words
      }
    },
    { name = 'luasnip' },
    -- { name = 'vsnip' },
    -- { name = 'crates' },
  },
  preselect = cmp.PreselectMode.None,
}



-- cmp-cmdline 在底部命令栏支持补全提示
-- require 'cmp'.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline({}),
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- iskeyword = @,48-57,_,192-255,-
vim.opt.iskeyword = vim.opt.iskeyword + '-'

-- keymap for luasnip
vim.cmd [[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]]

require 'luasnip.loaders.from_vscode'.load { include = { 'python', 'rust' } }
