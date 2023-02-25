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

local current_signature = function(width)
  if not pcall(require, 'lsp_signature') then return end
  local sig = require("lsp_signature").status_line(width)
  local sep = (sig.label ~= '' and ' || ') or ''
  return sig.hint .. sep .. sig.label
end

require 'lualine'.setup {
  options = { icons_enabled = false, theme = 'nord' },
  sections = {
    lualine_b = {
      'branch', { 'diff', source = diff_source }
    },
    lualine_c = {
      'diagnostics',
      { 'filename',                                  path = 1 },
      -- { function() return vim.fn['nvim_treesitter#statusline']() end },
      -- { 'lsp_progress',
      --   display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' } },
      --   timer = { progress_enddelay = 2000, spinner = 1000, lsp_client_name_enddelay = 2500 }
      -- },
      { function() return current_signature(nil) end },
    },
    lualine_x = { 'encoding', 'filetype' },
    lualine_z = { "vim.fn.line('.') .. '/' .. vim.fn.line('$') .. ':' .. vim.fn.col('.')", },
  }
}
