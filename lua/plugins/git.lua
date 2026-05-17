return {
  ---@type LazyPlugin
  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      integrations = { diffview = true },
      auto_show_console = false,
      console_timeout = 10000,
    },
    keys = {
      { "<space>n", "<cmd>Neogit<cr>", desc = "open Neogit" },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },
  {
    "niekdomi/conflict.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        live_grep = { additional_args = { "--ignore-file=.rgignore" } },
        grep_string = { additional_args = { "--ignore-file=.rgignore" } },
      },
    },
  },
}
