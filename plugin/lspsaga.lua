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
  ui               = {
    -- currently only round theme
    theme = 'round',
    -- border type can be single,double,rounded,solid,shadow.
    border = 'single',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = '',
    code_action = 'A',
    diagnostic = 'D',
    incoming = 'I ',
    outgoing = 'O ',
    colors = colors,
  },
  symbol_in_winbar = { enable = false },
  code_action      = {
    num_shortcut = false,
    keys = {
      -- string |table type
      quit = { '<Esc>', 'q' },
      exec = '<CR>',
    },
  },
  lightbulb        = { -- code_action hint
    enable = true,
    enable_in_insert = false,
    sign = true,
    sign_priority = 40,
    virtual_text = false,
  },
  preview          = { lines_above = 0, lines_below = 1, },
  scroll_preview   = { scroll_down = '<C-f>', scroll_up = '<C-b>', },
  request_timeout  = 10000,
  rename           = { quit = '<Esc>', },
  outline          = { keys = { quit = { '<Esc>', 'q' } }, },
  callhierarchy    = { keys = { quit = { '<Esc>', 'q' } }, },
}

saga.setup(new)
