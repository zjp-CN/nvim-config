local bind = vim.keymap.set
local cmp = require 'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.complete(),
    ['<C-c>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, }),
  }),

  -- Installed sources
  sources = {
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer', max_item_count = 20, keyword_length = 3,
      option = {
        get_bufnrs = function() return vim.api.nvim_list_bufs() end, -- search words in all buffers
        keyword_pattern = [[\k\+]], -- use the iskeyword option for recognizing words
      }
    },
    -- { name = "crates" },
  },
})

-- cmp-cmdline 在底部命令栏支持补全提示
require 'cmp'.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- iskeyword = @,48-57,_,192-255,-
vim.opt.iskeyword = vim.opt.iskeyword + '-'

-- vim-vsnip
vim.g.vsnip_snippet_dir = vim.fn.stdpath 'config' .. '/settings/vsnip'
local vsnip_opt = { silent = true, expr = true } -- 展开成 expr （函数计算的结果）
bind({ 'n', 'x' }, '<M-x>', '<Plug>(vsnip-cut-text)', vsnip_opt)
bind({ 'i', 'x' }, '<C-l>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-c>']], vsnip_opt)
bind({ 'i', 'x' }, '<S-Tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-c>']], vsnip_opt)
