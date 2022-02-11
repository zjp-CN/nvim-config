" === vim-markdown ===
let g:tex_conceal = ""
let g:vim_markdown_conceal_code_blocks = 0
" autocmd Filetype markdown set conceallevel=2

" === vim-table-mode ===
" 暂时对所用文件使用 `|` 分隔
let g:table_mode_corner = '|'

" === mdbook ===
" 保存时自动运行 mdbook build
autocmd BufWritePost,FileWritePost *.md call MdbookBuild()
function! MdbookBuild()
    if filereadable('./book.toml')
        echohl Title | echon ' mdbook build' | echohl None
        silent !mdbook build
    endif
endfunction 

" === vim-markdown === 
let g:vim_markdown_folding_disabled = 1
