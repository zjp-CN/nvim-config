require 'FTerm'.setup {
  border     = 'double',
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
}

local bind = require 'keymap'.bind
bind('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
bind('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
