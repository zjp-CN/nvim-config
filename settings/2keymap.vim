let mapleader ="\\"

" 使用 :verbose nmap \sn 等命令可以检测快捷键未被使用
" === vim 基本按键设置 ===
" F2 触发 paste 模式开关
set pastetoggle=<F2>
" F3 触发搜索高亮开关
nnoremap <F3> :noh<CR> 
" 触发行号 relative number
set number relativenumber
nnoremap <leader>nb :set number! rnu!<CR>
" 转换大小写
nnoremap <leader>u vgu
nnoremap <leader>U vgU
vnoremap <leader>u gu
vnoremap <leader>U gU
" nnoremap <leader>NB :set nu rnu<CR>
" 清除文件内容 delete all
nnoremap <leader>da ggVGD<F2>I
" 跳转缓冲区
nnoremap <leader>nn :bn<CR>
nnoremap <leader>pp :bp<CR>
nnoremap <leader>bd :bd<CR>
" 关闭缓冲区但不关闭 tab 窗口
nnoremap <leader>dd :bp<bar>sp<bar>bn<bar>bd<CR>
" nnoremap <leader>bn :bn<CR>
" nnoremap <leader>bp :bp<CR>
" nnoremap <leader>bd :bd<CR>
nnoremap <leader>bs :buffers<CR>
" 跳转 tabs
nnoremap <leader>tb :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>n :tabNext<CR>
nnoremap <leader>p :tabprevious<CR>
" nnoremap <leader>tn :tabNext<CR>
" nnoremap <leader>tp :tabprevious<CR>

" 保存、退出
nnoremap <leader>w :w<CR>
nnoremap <leader>wa :wa<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>qa :qa<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>xa :xa<CR>
nnoremap <leader>wbd :w \| :bd<CR>

" === :W :Q 命令 ===
" https://stackoverflow.com/questions/10590165/is-there-a-way-in-vim-to-make-w-to-do-the-same-thing-as-w 
" 注意这只会允许单独的 :W 和 :Q ，而不会 :WQ :Wq :wQ 
" command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
" command! -bang Q quit<bang>
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Xa xa
command! Qa xa
command! Wa wa
command! Wqa wqa
command! WQa wqa
command! E edit

" 快速编辑和加载配置文件，否则每次需要开新的终端，把当前文件关闭再打开使配置生效
" 为了方便，test 配置文件当作临时配置文件，有空可以分类到别的配置文件上去
let s:settings = expand(stdpath('config')) . '/settings'
function VsplitSettings()
  exe 'vsplit ' . s:settings
endfunction
nnoremap <leader>ec :call VsplitSettings()<cr>
nnoremap <leader>sc :source %<cr>

" === other tricks ===
" 向前向后插入空行
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" === neovim native terminal  ===
" https://neovim.io/doc/user/nvim_terminal_emulator.html
tnoremap <Esc> <C-\><C-n>
" nnoremap <leader>T :split \| :terminal <CR> a
nnoremap <leader>T :terminal <CR> afish <CR>
nnoremap <leader>ST :split \| :terminal <CR> afish <CR>
nnoremap <leader>VT :vsplit \| :terminal <CR> afish <CR>

" === lua ===

" Code navigation shortcuts
" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
"
" " Set updatetime for CursorHold
" " 300ms of no cursor movement to trigger CursorHold
" set updatetime=300
" " Show diagnostic popup on cursor hold
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
"
" " Goto previous/next diagnostic warning/error
" nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
