local playground = {
  enable = true,
  disable = {},
  updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  persist_queries = false, -- Whether the query persists across vim sessions
  keybindings = {
    toggle_query_editor = 'o',
    toggle_hl_groups = 'i',
    toggle_injected_languages = 't',
    toggle_anonymous_nodes = 'a',
    toggle_language_display = 'I',
    focus_language = 'f',
    unfocus_language = 'F',
    update = 'R',
    goto_node = '<cr>',
    show_help = '?',
  },
}

local incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = "gm",
    node_incremental = "gm",
    node_decremental = "gM",
    scope_incremental = "gc",
  },
}

local highlight = {
  enable = true,
  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  -- Using this option may slow down your editor, and you may see some duplicate highlights.
  -- Instead of true it can also be a list of languages
  additional_vim_regex_highlighting = { 'markdown', 'toml', 'vim' },
}

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'python', 'lua', 'rust', 'query',
    'css', 'html', 'bash', 'javascript', 'json', 'c', 'cpp', 'cmake', 'llvm',
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = highlight,
  playground = playground,
  incremental_selection = incremental_selection,
}

-- TODO: 自定义
vim.cmd [[
  " 禁用自动折叠
  set nofoldenable
  set foldmethod=expr

  " 第一行源代码 ........... 折叠行数 [折叠行数占总行数百分比] +--
  " src: http://gregsexton.org/2011/03/27/improving-the-text-displayed-in-a-vim-fold.html
  function! CustomFoldText() abort
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . printf("%d",foldSize) . " lines "
    let foldLevelStr = repeat("+-", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%2.0f%%] ", (foldSize*1.0)/lineCount*100)
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage)-1)
    return line . " " . expansionString . foldSizeStr . foldPercentage . foldLevelStr
  endfunction
  set foldtext=CustomFoldText()

  function! CustomFoldexpr() abort
    " 等价于 nvim_treesitter#foldexpr()
    " return getline(v:lnum)=~'^\\s*//'
    return luaeval(printf('require"nvim-treesitter.fold".get_fold_indic(%d)', v:lnum))
  endfunction

  set foldexpr=nvim_treesitter#foldexpr()

  autocmd Filetype rust :set foldexpr=getline(v:lnum)=~'^\\s*//'
  nnoremap <leader>fc :set foldexpr=getline(v:lnum)=~'^\\s*//'<cr>
  nnoremap <leader>ft :set foldexpr=nvim_treesitter#foldexpr()<cr>
]]
