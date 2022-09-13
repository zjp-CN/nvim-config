--[[
    替换 nnoremap <leader>bs :buffers<CR> 成 lua 函数
    :'<,'>s/\vnnoremap (.{-}) (.*)/bind('n', '\1', '\2')
    替换 command! WQ wq
    :'<,'>s/\vcommand! (.{-}) (.*)/new_cmd('\1', '\2', { bang = true })
--]]

local set     = vim.opt
local new_cmd = vim.api.nvim_create_user_command
local bind    = function(mode, key, result)
  vim.keymap.set(mode, key, result, { silent = true })
end

-- Leader: `\`
vim.g.mapleader = [[\]]

-- F2 触发 paste 模式开关
set.pastetoggle = '<F2>'

-- F3 触发搜索高亮开关
bind('', '<F3>', ':noh<CR>')

-- 触发行号 relative number: set number relativenumber
bind('', '<leader>nb', ':set number! rnu!<CR>')

-- 转换大小写
bind('n', '<leader>u', 'vgu')
bind('n', '<leader>U', 'vgU')
bind('v', '<leader>u', 'gu')
bind('v', '<leader>U', 'gU')

-- 清除文件内容 delete all
bind('n', '<leader>da', 'ggVGD<F2>I')
-- 跳转缓冲区
bind('n', '<leader>nn', ':bn<CR>')
bind('n', '<leader>pp', ':bp<CR>')
bind('n', '<leader>bd', ':bd<CR>')
-- 关闭缓冲区但不关闭 tab 窗口
bind('n', '<leader>dd', ':bp<bar>sp<bar>bn<bar>bd<CR>')
bind('n', '<leader>bs', ':buffers<CR>')
-- 跳转 tabs
bind('n', '<leader>tb', ':tabnew<CR>')

-- 保存、退出
bind('n', '<leader>w', ':w<CR>')
bind('n', '<leader>wa', ':wa<CR>')
bind('n', '<leader>q', ':q<CR>')
bind('n', '<leader>qa', ':qa<CR>')
bind('n', '<leader>wq', ':wq<CR>')
bind('n', '<leader>xa', ':wa | :qa<CR>')
bind('n', '<leader>wbd', ':w | :bd<CR>')

-- :W :Q 命令
new_cmd('WQ', 'wq', { bang = true })
new_cmd('Wq', 'wq', { bang = true })
new_cmd('W', 'w', { bang = true })
new_cmd('Q', 'q', { bang = true })
new_cmd('Xa', 'xa', { bang = true })
new_cmd('Qa', 'xa', { bang = true })
new_cmd('Wa', 'wa', { bang = true })
new_cmd('Wqa', 'wqa', { bang = true })
new_cmd('WQa', 'wqa', { bang = true })
new_cmd('E', 'edit', { bang = true })

-- 配置文件
bind('n', '<leader>ec', function()
  local path = vim.fn.stdpath('config')
  vim.api.nvim_command('vsplit ' .. path)
end)
bind('n', '<leader>sc', ':source %<cr>')

--[[
   移动切分窗口
   Ctrl-w t makes the first (topleft) window current
   Ctrl-w followed by H, J, K or L (capital) will move the current window to
   the far left, bottom, top or right respectively like normal cursor navigation.
-- ]]
bind('n', '<leader>th', '<C-w>t<C-w>H')
bind('n', '<leader>tj', '<C-w>t<C-w>J')
bind('n', '<leader>tk', '<C-w>t<C-w>K')
bind('n', '<leader>tl', '<C-w>t<C-w>L')

-- 向前向后插入空行
bind('n', '[<space>', ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[")
bind('n', ']<space>', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>')

-- neovim native terminal
-- https://neovim.io/doc/user/nvim_terminal_emulator.html
bind('t', '<Esc>', '<C-\\><C-n>')
bind('t', '<C-\\>', '<C-\\><C-n>')
bind('n', '<leader>T', ':terminal <CR> a')
bind('n', '<leader>ST', [[:split \| :resize 15 \| :terminal <CR> a]])
bind('n', '<leader>VT', [[:vsplit \| :terminal <CR> a]])

-- split window
bind('n', '<c-w>[', ':vertical resize -5<cr>')
bind('n', '<c-w>]', ':vertical resize +5<cr>')
bind('n', '<c-w>-', ':resize -5<cr>')
bind('n', '<c-w>+', ':resize +5<cr>')

-- ========================================================================== --
-- ==                                 LSP                                  == --
-- ========================================================================== --

local augroup = vim.api.nvim_create_augroup('mapping_cmds', { clear = true })
local autocmd = vim.api.nvim_create_autocmd

autocmd('User', {
  pattern = 'LSPKeybindings',
  group = augroup,
  callback = function()
    bind('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    bind('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
    bind('n', '<leader>gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>')

    bind('n', '<space>f', ":Telescope lsp_workspace_symbols<cr>")
    bind('n', '<C-s>', ":LspStop<cr> ")
    bind('n', '<M-s>', ":LspStart<cr> ")
  end
})

-- ========================================================================== --
-- ==                                Lspsaga                                  == --
-- ========================================================================== --

autocmd('User', {
  pattern = 'LSPSageKeybindings',
  group = augroup,
  callback = function()
    bind('n', ';c', "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>")
    bind('n', ';l', ":Lspsaga show_line_diagnostics<CR>")
    bind('n', '<leader>a', ":Lspsaga code_action<CR>")
    bind('n', '<leader>rn', ":Lspsaga rename<CR>")
    bind('n', '<space>d', ":Lspsaga preview_definition<cr>")
    bind('n', 'K', ":Lspsaga hover_doc<CR>")
    bind('n', '[d', ":Lspsaga diagnostic_jump_prev<CR>")
    bind('n', ']d', ":Lspsaga diagnostic_jump_next<CR>")
    bind('n', 'gr', ":Lspsaga lsp_finder<CR>")
    bind('v', '<leader>a', ':<C-U>Lspsaga range_code_action<CR>')
  end
})

local M = {}
M.bind = bind
M.augroup = augroup
M.autocmd = function(pat, callback)
  autocmd('User', { pattern = pat, group = augroup, callback = callback, })
end
return M
