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
