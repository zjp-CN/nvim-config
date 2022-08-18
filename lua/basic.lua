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

-- 禁用鼠标交互（如果不设置，默认为启用）
set.mouse = ''

-- colorscheme
-- vim.cmd(':source ' .. vim.fn.stdpath 'config' .. '/lua/colorscheme.vim')
-- vim.cmd 'colorscheme slate'
vim.cmd [[
set termguicolors
let g:sonokai_diagnostic_text_highlight=0
let g:sonokai_diagnostic_virtual_text=0
let g:sonokai_disable_terminal_colors=1

function! s:sonokai_custom() abort
  exec 'source '. stdpath('config') . '/lua/sonokai_custom.vim'
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
