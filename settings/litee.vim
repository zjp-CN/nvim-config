
lua << EOF
-- sample: https://github.com/ldelossa/dotfiles/blob/master/config/nvim/lua/configs/litee.lua
local icon_set_custom = {
    Account         = "",
    Array           = "\\[\\]",
    Bookmark        = "",
    Boolean         = "b",
    Calendar        = '',
    Check           = '',
    CheckAll        = '',
    Circle          = '',
    CircleFilled    = '●',
    CirclePause     = '',
    CircleSlash     = '',
    CircleStop      = '',
    Class           = "c",
    Collapsed       = "▶",
    Color           = "",
    Comment         = '//',
    CommentExclaim  = '//',
    Constant        = "c",
    Constructor     = "c",
    DiffAdded       = '+',
    Enum            = "Ε",
    EnumMember      = "Ε",
    Event           = "",
    Expanded        = "▼",
    Field           = "𝐟",
    File            = "f",
    Folder          = "F",
    Function        = "ƒ",
    GitBranch       = '',
    GitCommit       = '',
    GitCompare      = '',
    GitIssue        = '',
    GitPullRequest  = '',
    GitRepo         = '',
    History         = 'H',
    IndentGuide     = "",
    Info            = '',
    Interface       = "I",
    Key             = "k",
    Keyword         = "k",
    Method          = "m",
    Module          = "M",
    MultiComment    = '///',
    Namespace       = "N",
    Notebook        = "",
    Notification    = '',
    Null            = "null",
    Number          = "#",
    Object          = "{}",
    Operator        = "0",
    Package         = "{}",
    Pass            = '',
    PassFilled      = '',
    Pencil          = '',
    Property        = " ",
    Reference       = "",
    RequestChanges  = '',
    Separator       = "•",
    Space           = " ",
    String          = "\"",
    Struct          = "s",
    Sync            = '',
    Text            = "\"",
    TypeParameter   = "T",
    Unit            = "U",
    Value           = "v",
    Variable        = "V",
}

require('litee.lib').setup{
  --tree = { icon_set_custom = { Struct = "s" }, icon_set = "codicons" } 
  tree = { icon_set_custom = {Function="f"} } 
  -- tree = { icon_set = "codicons" }
}
local setup = {
  map_resize_keys = false,
  hide_cursor = true,
 -- icon_set_custom = {S = "fff"},
 --icon_set = "codicons",
}
require('litee.calltree').setup(setup)
require('litee.symboltree').setup({
  map_resize_keys = false,
  hide_cursor = true,
  icon_set_custom = {Function = "f-sym", File = "File"},
  -- icon_set = "codicons",
})
require'litee.filetree'.setup{
  map_resize_keys = false,
  use_web_devicons = false,
  icon_set_custom = {dir = "dir:", folder = "folder:", file = "file:"}, -- Provide icons you want.
  -- You don't need the following line if you want a default icon_set
  -- to be merged.
  icon_set = "codicons",
}

EOF


autocmd FileType symboltree nnoremap zo :LTExpandSymboltree<cr>
autocmd FileType symboltree nnoremap zr :LTExpandSymboltree<cr>
autocmd FileType symboltree nnoremap zm :LTCollapseSymboltree<cr>

autocmd FileType calltree nnoremap zo :LTExpandCalltree<cr>
autocmd FileType calltree nnoremap zr :LTExpandCalltree<cr>
autocmd FileType calltree nnoremap zm :LTCollapseCalltree<cr>
