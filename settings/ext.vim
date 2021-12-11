" 此文件用于设置拓展功能

" === vim-easy-align ===
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


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
