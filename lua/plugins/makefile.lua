return {
  { -- This plugin
    "Zeioth/makeit.nvim",
    cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
  },
  { -- The task runner we use
    "stevearc/overseer.nvim",
    commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
    cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
    event = { "BufReadPost *.rs", "BufNewFile *.rs" },
    keys = {
      { "<space><space>", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer Task List" },
      { "<space>r", "<cmd>OverseerRun<cr>", desc = "Run A Task (Overseer)" },
      { "<space>R", "<cmd>OverseerRunCmd<cr>", desc = "Run A Shell Command Task (Overseer)" },
    },
    opts = {
      templates = { "builtin", "rust" },
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
