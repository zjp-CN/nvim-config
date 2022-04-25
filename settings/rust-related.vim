" “format-on-write” (with a timeout of 200ms)
" autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
" rust.vim
let g:rustfmt_autosave = 1

" 使用 :make 代替 :!cargo
autocmd FileType rust compiler cargo
" autocmd FileType rust :set makeprg=cargo
" let g:rust_cargo_avoid_whole_workspace = 1


" bacon
set nowritebackup
set noequalalways

" === 代码折叠 ===
" autocmd Filetype rust set foldmethod=syntax
" 由于无法同时存在多个 foldmethod，所以可以通过快捷键来设置不同方式的折叠
nnoremap <leader>fs :set foldmethod=syntax<cr>
" nnoremap <leader>ff :set foldmethod=expr foldexpr=folding_nvim#foldexpr()<cr>
" autocmd FileType rust set foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*//'
nnoremap <leader>fe :set foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*//'<cr>
" " 更改原先行数在前的折叠样式
" " 第一行源代码 ........... 折叠行数 [折叠行数占总行数百分比] +--
" " http://gregsexton.org/2011/03/27/improving-the-text-displayed-in-a-vim-fold.html
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
" set foldtext=CustomFoldText()

" autocmd Filetype rust set foldmethod=syntax | set foldcolumn=auto | set foldtext=CustomFoldText()
autocmd Filetype rust set foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*//' | set foldtext=CustomFoldText()

" keymap
autocmd FileType rust nnoremap <silent> <C-s> :LspStop<cr> 
autocmd FileType rust nnoremap <silent> <M-s> :LspStart<cr> 
autocmd Filetype rust nnoremap <F6> :RustExpandMacro<CR> | nnoremap <F5> :RustHoverActions<CR>
autocmd FileType toml lua require('cmp').setup.buffer {
\ sources = {
    \        { name = 'crates' },
    \        { name = 'buffer' },
    \        { name = 'path' },
    \    }
\}
autocmd FileType toml nnoremap <silent> <F5> :lua require('crates').show_popup()<cr> 
autocmd FileType toml nnoremap <silent> <F6> :lua require('crates').show_dependencies_popup()<cr>
autocmd FileType toml nnoremap <silent> <F4> :lua require('crates').show_features_popup()<cr>
lua << EOF
require('crates').setup {
    text = {
        loading = "  Loading...",
        version = "  v%s",
        prerelease = "  %s",
        yanked = "  %s yanked",
        nomatch = "  Not found",
        upgrade = "  upgrade to v%s",
        error = "  Error fetching crate",
    },
    popup = {
        text = {
            title = " # %s ",
            version = " %s ",
            prerelease = " %s ",
            yanked = " %s yanked ",
            feature = "   %s ",
            enabled = " * %s ",
            transitive = " ~ %s ",
        },
        show_version_date = true,
    },
    text = {
        prerelease = " pre-release ",
        yanked = " yanked ",
    },
}
EOF


lua << EOF
-- local dap = require('dap')
-- dap.adapters.lldb = {
--   type = 'executable',
--   command = '/usr/bin/lldb-vscode-14', -- adjust as needed
--   name = "lldb"
-- }
-- dap.configurations.cpp = {
--   {
--     name = "Launch",
--     type = "lldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--     args = {},
-- 
--     -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
--     --
--     --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--     --
--     -- Otherwise you might get the following error:
--     --
--     --    Error on launch: Failed to attach to the target process
--     --
--     -- But you should be aware of the implications:
--     -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
--     runInTerminal = false,
--   },
-- }
-- 
-- 
-- -- If you want to use this for rust and c, add something like this:
-- 
-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp

vim.fn.sign_define('DapBreakpoint', {text='B', texthl='RedrawDebugComposed', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='→', texthl='PmenuThumb', linehl='', numhl=''})

-- nvim-dap-ui
require("dapui").setup({
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "repl", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "watches" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
EOF

" === nvim-dap ===
autocmd Filetype rust nnoremap <silent> <F7> :lua require'dap'.clear_breakpoints()<CR>
autocmd Filetype rust nnoremap <silent> <F8> :lua require'dap'.continue()<CR>
autocmd Filetype rust nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
autocmd Filetype rust nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
autocmd Filetype rust nnoremap <silent> <F12> :lua require'dap'.run_to_cursor()<CR>
autocmd Filetype rust nnoremap <silent> <C-i> :lua require'dap'.step_into()<CR>
autocmd Filetype rust nnoremap <silent> <C-o> :lua require'dap'.step_out()<CR>
autocmd Filetype rust nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle()<CR>
autocmd Filetype rust nnoremap <silent> <leader>dc :lua require'dap'.terminate()<CR>
autocmd Filetype rust nnoremap <silent> <leader>dt :lua require("dapui").toggle()<CR>

" === nvim-dap-ui ===
" https://github.com/rcarriga/nvim-dap-ui
" For a one time expression evaluation, you can call a hover window to show a value
autocmd Filetype rust nnoremap <C-k> <Cmd>lua require("dapui").eval()<CR>
autocmd Filetype rust nnoremap <M-k> <Cmd>lua require("dapui").float_element()<CR>


