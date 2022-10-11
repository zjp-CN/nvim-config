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
      -- { function() return vim.fn['nvim_treesitter#statusline']() end },
      -- { 'lsp_progress',
      --   display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' } },
      --   timer = { progress_enddelay = 2000, spinner = 1000, lsp_client_name_enddelay = 2500 }
      -- },
    },
    lualine_x = { 'encoding', 'filetype' },
    lualine_z = { "vim.fn.line('.') .. '/' .. vim.fn.line('$') .. ':' .. vim.fn.col('.')", },
  }
}
