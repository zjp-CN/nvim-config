-- sample: https://github.com/ldelossa/dotfiles/blob/master/config/nvim/lua/configs/litee.lua
local icon_set_custom = {
  Account        = "",
  Array          = "\\[\\]",
  Bookmark       = "",
  Boolean        = "b",
  Calendar       = '',
  Check          = '',
  CheckAll       = '',
  Circle         = '',
  CircleFilled   = '●',
  CirclePause    = '',
  CircleSlash    = '',
  CircleStop     = '',
  Class          = "c",
  Collapsed      = "▶",
  Color          = "",
  Comment        = '//',
  CommentExclaim = '//',
  Constant       = "c",
  Constructor    = "c",
  DiffAdded      = '+',
  Enum           = "Ε",
  EnumMember     = "Ε",
  Event          = "",
  Expanded       = "▼",
  Field          = "𝐟",
  File           = "f",
  Folder         = "F",
  Function       = "ƒ",
  GitBranch      = '',
  GitCommit      = '',
  GitCompare     = '',
  GitIssue       = '',
  GitPullRequest = '',
  GitRepo        = '',
  History        = 'H',
  IndentGuide    = "",
  Info           = '',
  Interface      = "I",
  Key            = "k",
  Keyword        = "k",
  Method         = "m",
  Module         = "M",
  MultiComment   = '///',
  Namespace      = "N",
  Notebook       = "",
  Notification   = '',
  Null           = "null",
  Number         = "#",
  Object         = "{}",
  Operator       = "0",
  Package        = "{}",
  Pass           = '',
  PassFilled     = '',
  Pencil         = '',
  Property       = " ",
  Reference      = "",
  RequestChanges = '',
  Separator      = "•",
  Space          = " ",
  String         = "\"",
  Struct         = "s",
  Sync           = '',
  Text           = "\"",
  TypeParameter  = "T",
  Unit           = "U",
  Value          = "v",
  Variable       = "V",
}

require 'litee.lib'.setup { tree = { icon_set_custom = icon_set_custom } }

local setup = { map_resize_keys = false, hide_cursor = true, }

require 'litee.calltree'.setup(setup)
require 'litee.symboltree'.setup {
  map_resize_keys = false,
  hide_cursor = true,
  icon_set_custom = icon_set_custom,
}
require 'litee.filetree'.setup {
  map_resize_keys = false,
  use_web_devicons = false,
  icon_set_custom = { dir = "dir:", folder = "folder:", file = "file:" }, -- Provide icons you want.
}

local autocmd = vim.api.nvim_create_autocmd
local bind = require 'keymap'.bind

autocmd('FileType', {
  pattern = 'symboltree',
  callback = function()
    bind('n', 'zo', ":LTExpandSymboltree<cr>")
    bind('n', 'zr', ":LTExpandSymboltree<cr>")
    bind('n', 'zm', ":LTCollapseSymboltree<cr>")
  end
})

autocmd('FileType', {
  pattern = 'calltree',
  callback = function()
    bind('n', 'zo', ":LTExpandCalltree<cr>")
    bind('n', 'zr', ":LTExpandCalltree<cr>")
    bind('n', 'zm', ":LTCollapseCalltree<cr>")
  end
})
