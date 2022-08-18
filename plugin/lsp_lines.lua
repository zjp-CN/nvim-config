-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config {
  virtual_text = false,
}

require 'keymap'.bind('n', '<space>D', ':lua require"lsp_lines".toggle()<CR>')
