" “format-on-write” (with a timeout of 200ms)
" autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
" rust.vim
let g:rustfmt_autosave = 1

" 使用 :make 代替 :!cargo
autocmd FileType rust compiler cargo
" autocmd FileType rust :set makeprg=cargo
" let g:rust_cargo_avoid_whole_workspace = 1


" === 代码折叠 ===
" autocmd Filetype rust set foldmethod=syntax
" 由于无法同时存在多个 foldmethod，所以可以通过快捷键来设置不同方式的折叠
nnoremap <leader>fs :set foldmethod=syntax<cr>
autocmd FileType rust set foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*//'
nnoremap <leader>fe :set foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*//'<cr>
" 更改原先行数在前的折叠样式
" 第一行源代码 ........... 折叠行数 [折叠行数占总行数百分比] +--
" http://gregsexton.org/2011/03/27/improving-the-text-displayed-in-a-vim-fold.html
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
