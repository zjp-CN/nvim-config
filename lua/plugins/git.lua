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
    opts = {
      use_icons = false,
      enhanced_diff_hl = true,
      default_args = {
        DiffviewOpen = { "--untracked-files=no" },
        DiffviewFileHistory = { "--base=LOCAL" },
      },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    cmd = "GitConflictListQf",
    opts = {},
  },
}
