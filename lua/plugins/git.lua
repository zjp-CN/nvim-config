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
      { "<space>n", "<cmd>Neogit<cr>", "open Neogit" },
    },
  },
}
