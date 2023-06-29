local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

require 'lualine'.setup {
  options = { icons_enabled = false, theme = 'nord' },
  sections = {
    lualine_b = {
      'branch', { 'diff', source = diff_source }
    },
    lualine_c = {
      'diagnostics',
      { 'filename', path = 1 },
    },
    lualine_x = {
      'encoding',
      'filetype',
      {
        'fileformat',
        icons_enabled = true,
        symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR', },
      },
    },
    lualine_z = { "vim.fn.line('.') .. '/' .. vim.fn.line('$') .. ':' .. vim.fn.col('.')", },
  }
}
