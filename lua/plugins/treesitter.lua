return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<space>s",
          node_incremental = "<space>s",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      ensure_installed = {
        "rust",
        "sql",
      },
    },
  },
}
