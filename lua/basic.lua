local set = vim.opt
local fn  = vim.fn

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

set.timeoutlen = 500

-- colorscheme
vim.cmd(':source ' .. vim.fn.stdpath 'config' .. '/lua/colorscheme.vim')

-- 如果没有这个设置，每次打开文件时光标都将定位在第一行。
-- 而加入了这个设置以后，你就可以恢复到上次关闭文件时光标所在的位置了。
-- https://github.com/wsdjeg/vim-galore-zh_cn
vim.cmd [[
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
]]
