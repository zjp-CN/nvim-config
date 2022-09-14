-- vim.opt.mouse = "nvi"
-- vim.g.netrw_mousemaps = 1

-- src: https://vi.stackexchange.com/questions/29381/how-do-i-enable-mouse-in-netrw-only-terminal-vim
-- enable mouse in netrw
vim.cmd [[
function! s:NetrwMouseOn()
  set mouse=n
endfunction

function! s:NetrwMouseOff()
  set mouse=
endfunction

au FileType netrw :call s:NetrwMouseOn()
au FileType netrw au BufEnter <buffer> :call s:NetrwMouseOn() 
au FileType netrw au BufLeave <buffer> :call s:NetrwMouseOff()
au FileType netrw nmap <buffer> <LeftMouse> <LeftMouse> <CR>
]]
