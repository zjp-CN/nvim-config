return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ui = {
        windows = {
          default_options = {
            -- make border rounded
            border = "rounded",
          },
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        -- add a border to hover docs and signature help
        lsp_doc_border = true,
      },
    },
  },
}
