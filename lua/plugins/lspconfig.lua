-- :h lspconfig-global-defaults (override global defaults for all servers)
-- Don't autostart when opening a file, manually call `:LspStart` instead.
local lspconfig = require("lspconfig")
lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  autostart = false,
})

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ui = {
        windows = {
          default_options = {
            border = "rounded", -- make border rounded
          },
        },
      },
      servers = {
        ["rust_analyzer"] = {},
        ["lua_ls"] = {},
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
}
