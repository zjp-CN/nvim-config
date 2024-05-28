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
    config = function()
      local opts = require("diffview.config").defaults
      opts = vim.tbl_extend("force", opts, {
        -- use_icons = false,
        enhanced_diff_hl = true,
        default_args = {
          DiffviewOpen = { "--untracked-files=no" },
          DiffviewFileHistory = { "--base=LOCAL" },
        },
      })
      for _, key in ipairs(opts.keymaps.view) do
        key[2] = string.gsub(key[2], "<leader>c", "<leader>g", 1)
      end
      for _, key in ipairs(opts.keymaps.file_panel) do
        key[2] = string.gsub(key[2], "<leader>c", "<leader>g", 1)
      end
      require("diffview").setup(opts)
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    cmd = "GitConflictRefresh",
    opts = {},
  },
}
