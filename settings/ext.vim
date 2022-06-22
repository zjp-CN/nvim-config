" 此文件用于设置拓展功能

" " == auto-pairs ===
" let g:AutoPairsCompatibleMaps = 0
" " 在 plugged/auto-pairs/autoload/autopairs/Variables.vim 下
" " 定义了一些快捷键，但是我不需要
" let g:AutoPairsMoveExpression = ""
" let g:AutoPairsShortcutToggleMultilineClose = ""
" let g:AutoPairsShortcutJump = ""
" let g:AutoPairsShortcutToggle = ""
" let g:AutoPairsShortcutFastWrap = ""

" === vim-easy-align ===
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" === clever-f ===
" `f\` matches all symbols
let g:clever_f_chars_match_any_signs='\\'

" augroup ScrollbarInit
"   autocmd!
"   autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()
"   autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
"   autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
" augroup end

" === nerdcommenter ===
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'rust': { 'left': '/*', 'right': '*/', 'leftAlt': '///','rightAlt': '' } }
let g:NERDCustomDelimiters = { 'rust': { 'left': '//', 'right': '', 'leftAlt': '///','rightAlt': '' }, 'toml':{'left': '#', 'right': ''}}
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" ban & override the nested comment
" let NERDDefaultNesting = 0
" nnoremap <silent> <leader>cc :call NERDComment('n', 'toggle')<CR>
" Specifies if trailing whitespace should be deleted when uncommenting
let NERDTrimTrailingWhitespace = 1

" === vista.vim ===
let g:vista_default_executive = 'nvim_lsp'
" let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_icon_indent = ["▸", ""]
let g:vista_sidebar_open_cmd = '10split'
" let g:vista_sidebar_open_cmd = '15vsplit'
let g:vista_cursor_delay = 250
let g:vista_echo_cursor_strategy = 'floating_win'
nnoremap <leader>v :Vista!!<CR>

set timeoutlen=500
lua << EOF
require("which-key").setup {
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
}
EOF

lua << EOF
-- hlslens
local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_set_keymap('n', '<Leader>l', ':noh<CR>', kopts)
-- scrollbar
require("scrollbar").setup{
    handle = {
        text = "  ",
    },
    marks = {
        Search = { color = "yellow", text = { "──", "━━" } },
        Error =  { color = "red",    text = { "──", "━━" } },
        Warn =   { color = "orange", text = { "──", "━━" } },
        Info =   { color = "white",  text = { "──", "━━" } },
        Hint =   { color = "white",  text = { "──", "━━" } },
        Misc =   { color = "white",  text = { "──", "━━" } },
    },
}
require("scrollbar.handlers.search").setup()
EOF

