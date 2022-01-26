" 加载配置文件
for s:path in split(glob(expand(stdpath('config')) . '/settings/' . '*.vim', "\n"))
  exe 'source ' . s:path
endfor

lua << EOF
vim.lsp.set_log_level("info")
EOF
