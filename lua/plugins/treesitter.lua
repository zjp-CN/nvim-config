return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gs",
          node_incremental = "gs",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },
}
