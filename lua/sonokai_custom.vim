" 四色盘 https://paletton.com/#uid=75x0X0kzxllp-tDuDpEHkgUQ9bn
hi! DiagnosticError guifg=#C10825 ctermbg=none
hi! DiagnosticWarn  guifg=#CC8309 ctermbg=none
hi! DiagnosticInfo  guifg=#2A5A9B ctermbg=none
hi! DiagnosticHint  guifg=#66875A ctermbg=none

hi! link DiagnosticVirtualTextError DiagnosticError
hi! link DiagnosticVirtualTextWarn  DiagnosticWarn
hi! link DiagnosticVirtualTextInfo  DiagnosticInfo
hi! link DiagnosticVirtualTextHint  DiagnosticHint

hi! CocInlayHint guifg=#2C2648 guibg=#617974 gui=inverse
hi! Search       guibg=#FFF093

" Treesitter
hi! TSString      guifg=#9F8B69
hi! TSFuncMacro   guifg=#9E90C5
" Symtols-tree
hi! SymTSType     guifg=#2A5A9B gui=inverse
hi! SymTSMethod   guifg=#2A5A9B gui=inverse
hi! SymTSField    guifg=#617974
hi! SymTSFunction guifg=#2A5A9B
hi! SymInterface  guifg=#AA4439 gui=inverse
hi! SymObj        guifg=#AA4439

" https://paletton.com/#uid=7040V0kL8pLtPDIHlvtORkLT4e+
hi! link                 DiffDelete    DiffviewDiffDelete
hi! GitSignsAddVirtLn    guifg=#009B22 guibg=white gui=inverse
hi! GitSignsChangeVirtLn guifg=#08298B guibg=white gui=inverse
hi! GitSignsDeleteVirtLn guifg=#740B00 guibg=white gui=inverse
" word_diff
hi! GitSignsAddInline    guifg=white guibg=#2B803E
hi! GitSignsChangeInline guifg=white guibg=#2F4073
hi! GitSignsDeleteInline guifg=white guibg=#AA4439
" toggle_deleted
hi! link GitSignsDeleteLnInline DiffviewDiffDelete

" Neogit
hi! NeogitDiffContextHighlight guibg=#393838

" git-conflict
hi! GitCurrent  guifg=black guibg=#3E5042
hi! GitIncoming guifg=black guibg=#1D213E

hi! DiffText guifg=#740B00 guibg=#FFD885 gui=inverse
