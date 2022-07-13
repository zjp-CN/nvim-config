local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

-- vim-markdown
g.tex_conceal = ""
g.vim_markdown_conceal_code_blocks = 0

-- vim-table-mode
-- 暂时对所用文件使用 `|` 分隔
g.table_mode_corner = '|'

-- 保存时自动运行 mdbook build
autocmd('BufWritePost', {
  pattern = '*.md',
  callback = function()
    if vim.fn.filereadable './book.toml' then
      vim.cmd [[
          echohl Title | echon ' mdbook build' | echohl None
          silent !mdbook build
        ]]
    end
  end
})

-- vim-markdown
g.vim_markdown_folding_disabled = 1
