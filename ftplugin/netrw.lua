-- vim.opt.mouse = "nvi"
-- vim.g.netrw_mousemaps = 1

vim.cmd [[
function! s:NetrwMapping()
  " quit preview, `p` for preview
  nmap <buffer> P <C-w>z
  " toggle marking files the op comes from
  nmap <buffer> <TAB> mf
  " quit marks on current buffer
  nmap <buffer> <S-TAB> mF
  " quit marks on all files
  nmap <buffer> <space><TAB> mu 
  " toggle hidden files/dirs
  nmap <buffer> . gh
endfunction

au filetype netrw call s:NetrwMapping()
]]
