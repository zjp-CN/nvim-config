set termguicolors
" 弹出菜单
hi  Pmenu        ctermbg=LightRed
hi  PmenuSbar    ctermbg=LightRed
hi  PmenuSel     ctermbg=LightCyan
hi  PmenuThumb   ctermbg=LightCyan
" 字调整
hi  Keyword      ctermfg=Red
hi  Function     ctermfg=DarkBlue
hi  Type         ctermfg=Yellow   ctermbg=Black cterm=none
hi  CocHintSign  ctermfg=Brown    cterm=underline
hi  Comment      ctermfg=DarkGray cterm=italic
hi  Identifier   cterm=bold       ctermfg=Blue
hi  Macro        ctermfg=Red      cterm=bold
" Delimiter
hi  Special      ctermfg=Magenta
hi  String       ctermfg=Gray
hi  Operator     ctermfg=Red      cterm=bold
hi  LineNr       ctermfg=White

" === GUI ===
" 弹出菜单
hi  Pmenu        guibg=#0A54A0
hi  CocErrorSign guifg=#FD3F3F
hi! link         PmenuSbar        Pmenu
hi  PmenuSel     guibg=#F69300
hi! link         PmenuThumb       PmenuSel
" 字调整
hi  Keyword      guifg=#FFA89A
hi  Function     guifg=#58D0F2    guibg=none
hi  Type         guifg=#54F685    gui=bold
hi  CocHintSign  guifg=#f06292    gui=underline
hi  Comment      guifg=#80cbc4    guibg=none    gui=italic
hi  InlayHints   guifg=Grey40     guibg=none    gui=italic
hi  Identifier   gui=none         guifg=#FFFF4D gui=bold
hi  Macro        guifg=#FD3F3F    gui=bold
" Delimiter
hi  Special      guifg=#FFA89A
hi  String       guifg=#9e9e9e
hi  Operator     guifg=#f44336    gui=bold
hi  LineNr       guifg=Grey70
hi  Normal       guifg=#F3FCFE    guibg=Black
hi! link         SpecialComment   Comment
hi  Folded       guibg=#292A00    guifg=#FFFF00
hi  CocHintSign  guibg=Black
hi  CocMenuSel   gui=inverse
hi  Visual       ctermbg=242      guibg=Grey30

" === neovim ===
hi FloatBorder guifg=grey50
hi NormalFloat guifg=#7cc6f4
" === gitsigns.nvim ===
hi GitSignsCurrentLineBlame guifg=Grey35 gui=inverse
hi GitSignsAdd guifg=White guibg=#1E49C8 
" === lualine ===
hi! DiagnosticError guifg=Red     ctermbg=none
hi! DiagnosticWarn  guifg=Yellow  ctermbg=none
hi! DiagnosticInfo  guifg=#7cc6f4 ctermbg=none
hi! DiagnosticHint  guifg=#F3FCFE ctermbg=none
