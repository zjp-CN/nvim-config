" lspconfig 设置 
" https://github.com/neovim/nvim-lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --
  -- buf_set_keymap('n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- folding-nvim config
  -- require('folding').on_attach()
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'rust_analyzer' }
-- 需要 cmp_nvim_lsp：利用 lsp 补全函数默认参数名
capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--for _, lsp in ipairs(servers) do
--  nvim_lsp[lsp].setup {
--    on_attach = on_attach,
--    flags = {
--      debounce_text_changes = 150,
--    },
--    capabilities = capabilities,
--  }
--end

-- rust-tools 设置
-- https://github.com/simrat39/rust-tools.nvim#configuration
-- Update this path
local extension_path = '/rust/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "// <-",
            other_hints_prefix = "// ",
            highlight = "InlayHints",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_attach,
        flags = { debounce_text_changes = 150, },
        capabilities = capabilities,

        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    enable = true,
                    command = "clippy",
                },
                -- cargo = {
                --     features = {"use_tokio"},
                -- },
            }
        },

        standalone = true,
    },

    -- debugging stuff
    -- dap = {
    --     adapter = {
    --         type = 'executable',
    --         command = 'lldb-vscode-14',
    --         name = "rt_lldb"
    --     }
    -- },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    },

    runnables = {
        -- whether to use telescope for selection menu or not
        use_telescope = true,

        -- rest of the opts are forwarded to telescope
    },
    debuggables = {
        -- whether to use telescope for selection menu or not
        use_telescope = true,

        -- rest of the opts are forwarded to telescope
        --pickers = {
        --  grep_string = { theme = "dropdown", },
        --  diagnostics = { theme = "dropdown", },
        --},
    },
}

require('rust-tools').setup(opts)
EOF

nnoremap <leader>ls :LspStop \| :LspStart<CR>
" nnoremap gd :lua vim.lsp.buf.definition()<CR>
" nnoremap <leader>gD <Cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <leader>gi <Cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <leader>gt <Cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <leader>gr <Cmd>lua vim.lsp.buf.references()<CR>

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone

" Avoid showing extra messages when using completion
" set shortmess+=c

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-m>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    --['<S-Tab>'] = cmp.mapping.select_prev_item(),
    --['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.complete(),
    ['<C-c>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
   -- ['<CR>'] = function(fallback)
   --   if cmp.visible() then
   --     cmp.confirm()
   --   else
   --     fallback() -- If you are using vim-endwise, this fallback function will be behaive as the vim-endwise.
   --   end
   -- end
  }),

  -- Installed sources
  sources = {
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'vsnip'    },
    { name = 'path'     },
    { name = 'buffer',
      option = {
          get_bufnrs = function() return vim.api.nvim_list_bufs() end, -- search words in all buffers
          keyword_pattern = [[\k\+]], -- use the iskeyword option for recognizing words
      }
    },
    -- { name = "crates" },
  },

  -- https://github.com/hrsh7th/nvim-cmp/issues/101
  -- completion = {
  --   get_trigger_characters = function(trigger_characters)
  --     return vim.tbl_filter(function(char)
  --       return char ~= ' '
  --     end, trigger_characters)
  --   end
  -- },
})

-- cmp-cmdline 在底部命令栏支持补全提示
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = { { name = 'buffer' } },
    mapping = cmp.mapping.preset.cmdline(),
})
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources(
--     { { name = 'path' } },
--     { { name = 'cmdline'} })
-- })

-- The following example advertise capabilities to `rust_analyzer-standalone`.
-- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- require'lspconfig'['rust_analyzer-standalone'].setup {
--   capabilities = capabilities,
-- }
EOF

" iskeyword = @,48-57,_,192-255,-
set iskeyword+=-

" === vim-vsnip ===
let g:vsnip_snippet_dir = expand(stdpath('config')) . '/settings/vsnip'
" Expand
" imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" Expand or jump
" imap <expr> <C-n>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-n>'
" smap <expr> <C-n>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-n>'
" Jump forward or backward
imap <expr> <C-l> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-c>'
smap <expr> <C-l> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-c>'
" imap <expr> <Tab> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : ''
" smap <expr> <Tab> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : ''
" 这个不能设置成 <C-m>，可能与 cmp 冲突（仅对我个人的配置而言）
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-c>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-c>'


" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
" nmap <M-x> <Plug>(vsnip-select-text)
" xmap <M-x> <Plug>(vsnip-select-text)
nmap <M-x> <Plug>(vsnip-cut-text)
xmap <M-x> <Plug>(vsnip-cut-text)


" 原项目：https://github.com/glepnir/lspsaga.nvim 
" 维护版：https://github.com/tami5/lspsaga.nvim 
lua << EOF
local saga = require 'lspsaga'
-- saga.init_lsp_saga()
saga.init_lsp_saga {
  -- add your config value here
  -- default value
  -- use_saga_diagnostic_sign = true
  error_sign = 'E',
  warn_sign = 'W',
  hint_sign = 'H',
  infor_sign = 'I',
  diagnostic_header_icon = '',
  code_action_icon = '',
  -- code_action_prompt = {
  --   enable = true,
  --   sign = true,
  --   sign_priority = 20,
  --   virtual_text = true,
  -- },
  finder_definition_icon = '',
  finder_reference_icon = '',
  max_preview_lines = 20, -- preview lines of lsp_finder and definition preview
  finder_action_keys = {
    open = '<CR>', vsplit = 's',split = 'i',quit = '<Esc>',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
  },
  code_action_keys = {
    quit = '<Esc>',exec = '<CR>'
  },
  rename_action_keys = {
    quit = '<Esc>',exec = '<CR>'  -- quit can be a table
  },
  definition_preview_icon = ''
  -- "single" "double" "round" "plus"
  -- border_style = "single"
  -- rename_prompt_prefix = '➤',
  -- if you don't use nvim-lspconfig you must pass your server name and
  -- the related filetypes into this table
  -- like server_filetype_map = {metals = {'sbt', 'scala'}}
  -- server_filetype_map = {}
}
EOF

nnoremap <silent> gr :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>a :Lspsaga code_action<CR>
vnoremap <silent><leader>a :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent> K :Lspsaga hover_doc<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> <leader>rn :Lspsaga rename<CR>
" nnoremap <silent> gd :Lspsaga preview_definition<CR>
nnoremap <silent> ;l :Lspsaga show_line_diagnostics<CR>
nnoremap <silent> ;c <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>
nnoremap <silent> ]d :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> [d :Lspsaga diagnostic_jump_prev<CR>
" nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
" tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>


lua << EOF
require('telescope').setup{
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.95, height = 0.95, prompt_position = 'top' }
    },
  },
  --pickers = {
  --  grep_string = { theme = "dropdown", },
  --  diagnostics = { theme = "dropdown", },
  --},
}
EOF

" === nvim-autopairs ===
lua << EOF
local npairs = require('nvim-autopairs')
-- TODO: fast_wrap 
npairs.setup({map_cr = true}) --> 没有映射 <CR> 的时候；如果 cmp 映射了 <CR>，需要按照官方说明设置

local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
npairs.add_rules({
  Rule("<", ">")
	-- don't add a pair if the next character is %
	:with_pair(cond.not_after_regex("%d"))
  }
)
EOF


" autocmd Filetype rust nnoremap <F4> :RustToggleInlayHints<cr>
autocmd Filetype rust nnoremap <leader>ct :RustOpenCargo<cr>

