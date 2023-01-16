local saga = require 'lspsaga'

local colors = {
  --float window normal bakcground color
  normal_bg = '#1d1536',
  --title background color
  title_bg = '#afd700',
  red = '#e95678',
  magenta = '#b33076',
  orange = '#FF8700',
  yellow = '#f7bb3b',
  green = '#afd700',
  cyan = '#36d0e0',
  blue = '#61afef',
  purple = '#CBA6F7',
  white = '#d1d4cf',
  black = '#1c1c19',
}

local new = {
  ui = {
    -- currently only round theme
    theme = 'round',
    -- border type can be single,double,rounded,solid,shadow.
    border = 'solid',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = '',
    code_action = 'A',
    diagnostic = 'D',
    incoming = 'I ',
    outgoing = 'O ',
    colors = colors,
    kind = {
      File = { 'F ', colors.white },
      Module = { 'M ', colors.blue },
      Namespace = { 'N ', colors.orange },
      Package = { 'P ', colors.purple },
      Class = { 'C ', colors.purple },
      Method = { ' ', colors.purple },
      Property = { 'P ', colors.cyan },
      Field = { ' ', colors.yellow },
      Constructor = { ' ', colors.blue },
      Enum = { 'E', colors.green },
      Interface = { ' ', colors.orange },
      Function = { 'F ', colors.purple },
      Variable = { ' ', colors.blue },
      Constant = { ' ', colors.cyan },
      String = { 'S ', colors.green },
      Number = { 'N ', colors.green },
      Boolean = { ' ', colors.orange },
      Array = { 'A ', colors.blue },
      Object = { 'O ', colors.orange },
      Key = { 'K ', colors.red },
      Null = { 'Null ', colors.red },
      EnumMember = { 'E ', colors.green },
      Struct = { 'S ', colors.purple },
      Event = { 'Eve ', colors.purple },
      Operator = { 'O ', colors.green },
      TypeParameter = { 'TPara ', colors.green },
      -- ccls
      TypeAlias = { 'T ', colors.green },
      Parameter = { 'Para ', colors.blue },
      StaticMethod = { 'M ', colors.orange },
      Macro = { ' ', colors.red },
      -- for completion sb microsoft!!!
      Text = { 'T ', colors.green },
      Snippet = { ' ', colors.blue },
      Folder = { ' ', colors.yellow },
      Unit = { 'U ', colors.cyan },
      Value = { 'V ', colors.blue },
    },
  },
  symbol_in_winbar = { enable = false },
  code_action = {
    num_shortcut = true,
    keys = {
      -- string |table type
      quit = 'q',
      exec = '<CR>',
    },
  },
  lightbulb = { -- code_action hint
    enable = true,
    enable_in_insert = false,
    sign = true,
    sign_priority = 40,
    virtual_text = false,
  },
  preview = {
    lines_above = 0,
    lines_below = 1,
  },
  scroll_preview = {
    scroll_down = '<C-f>',
    scroll_up = '<C-b>',
  },
  request_timeout = 2000,
}

saga.setup(new)
