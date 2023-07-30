local set = vim.opt
local api = vim.api

-- show existing tab with 4 spaces width
set.tabstop = 4
-- when indenting with '>', use 4 spaces width
set.shiftwidth = 4
-- On pressing tab, insert 4 spaces
set.expandtab = true
-- 避免长行从单词中间断开
set.linebreak = true

-- 切分窗口开启方式
set.splitright = true
set.splitbelow = true

-- 多 buffer 只留一个 statusline
set.laststatus = 3

set.timeoutlen = 500

set.fillchars:append 'diff:╱'

set.scrolloff = 6
set.nu = false
set.relativenumber = false

-- vim.api.nvim_create_autocmd('BufReadPre', {
--   command = ':if filereadable("Session.vim") | mksession! | echomsg "Session saved" | endif',
-- })

-- use nu on windows, but many plugins may still depends on cmd
-- so use `:e term://nu` to open the nu shell instead
set.shell = 'cmd'

-- 禁用鼠标交互（如果不设置，默认为启用 'nvi'）
set.mouse = ''
vim.cmd [[
function! s:NetrwMouseOn()
  set mouse=nv
endfunction

function! s:NetrwMouseOff()
  set mouse=
endfunction

let g:netrw_keepdir = 1
" let g:netrw_liststyle=3

" enable mouse in netrw
" src: https://vi.stackexchange.com/questions/29381/how-do-i-enable-mouse-in-netrw-only-terminal-vim
au FileType netrw,help :call s:NetrwMouseOn()
au FileType netrw,help au BufEnter <buffer> :call s:NetrwMouseOn()
au FileType netrw,help au BufLeave <buffer> :call s:NetrwMouseOff()
au FileType netrw,help nmap <buffer> <LeftMouse> <LeftMouse> <CR>
]]

-- colorscheme
vim.cmd [[
set termguicolors
let g:sonokai_diagnostic_text_highlight=0
let g:sonokai_diagnostic_virtual_text=0
let g:sonokai_disable_terminal_colors=1

function! s:sonokai_custom() abort
  exec 'source '. stdpath('config') . '/lua/sonokai.vim'
endfunction

augroup SonokaiCustom
  autocmd!
  autocmd ColorScheme sonokai call s:sonokai_custom()
augroup END

colorscheme sonokai
]]

-- 如果没有这个设置，每次打开文件时光标都将定位在第一行。
-- 而加入了这个设置以后，你就可以恢复到上次关闭文件时光标所在的位置了。
-- https://github.com/wsdjeg/vim-galore-zh_cn
-- vim.cmd [[
-- autocmd BufReadPost *
--     \ if line("'\"") > 1 && line("'\"") <= line("$") |
--     \   exe "normal! g`\"" |
--     \ endif
-- ]]

-- src: https://www.reddit.com/r/neovim/comments/tqeh9m/comment/i2hbc4p
local group = api.nvim_create_augroup("jump_last_position", { clear = true })
api.nvim_create_autocmd(
  "BufReadPost",
  {
    group = group,
    callback = function()
      local row, col = unpack(api.nvim_buf_get_mark(0, "\""))
      if row <= vim.fn.line('$') then
        api.nvim_win_set_cursor(0, { row, col })
      end
    end,
  }
)
