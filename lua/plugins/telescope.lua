local on_windows = jit.os == "Windows"
local smart_history = on_windows
    and { history = { path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3", limit = 100 } }
  or {}

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- general keymap: builtin
      { ",t", "<cmd>Telescope<cr>" },
      { ",l", "<cmd>Telescope live_grep<cr>" },
      { ",g", "<cmd>Telescope grep_string<cr>" },
      { ",f", "<cmd>Telescope find_files<cr>" },
      { ",F", "<cmd>Telescope find_files no_ignore=true<cr>" },
      { ",h", "<cmd>Telescope highlights<cr>" },
      { ",,", "<cmd>Telescope help_tags<cr>" },
      { ",k", "<cmd>Telescope keymaps<cr>" },
      { ",b", "<cmd>Telescope buffers<cr>" },
      { ",B", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
      { ",q", "<cmd>Telescope quickfix<cr>" },
      { ",Q", "<cmd>Telescope quickfixhistory<cr>" },
      { ",x", "<cmd>Telescope commands<cr>" },
    },
  },
  -- classify histories in Telescope
  {
    "nvim-telescope/telescope-smart-history.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
      {
        "nvim-telescope/telescope.nvim",
        opts = { defaults = smart_history },
      },
    },
    cmd = "Telescope", -- there is a bug to start this plugin by run Telescope cmd
    keys = {
      { ",t", "<cmd>Telescope<cr>", desc = "start Telescope" },
      { ";t", "<cmd>Telescope<cr>", desc = "start Telescope" },
    },
    config = function()
      require("telescope").load_extension("smart_history")
    end,
  },
  -- alternative to neotree, but always works
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    cmd = "Telescope file_browser",
    keys = {
      { "<space>f", "<cmd>Telescope file_browser<cr>", desc = "browser files in root dir" },
      {
        "<space>F",
        '<cmd>lua require"telescope".extensions.file_browser.file_browser{path=vim.fn.expand"%:p:h"}<cr>',
        desc = "browser files in current dir",
      },
      {
        ";f",
        "<cmd>Telescope file_browser respect_gitignore=false<cr>",
        desc = "browser file in root dir without gitignore",
      },
      {
        ";F",
        '<cmd>lua require"telescope".extensions.file_browser.file_browser{path=vim.fn.expand"%:p:h", respect_gitignore=false}<cr>',
        desc = "browser file in current dir without gitignore",
      },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
  -- file history for selection & read
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = {
      {
        "kkharji/sqlite.lua",
        config = function()
          if on_windows then
            vim.g.sqlite_clib_path = "E://Programming//sqlite3//sqlite3.dll"
          end
        end,
      },
    },
    keys = {
      { ",c", "<cmd>Telescope frecency workspace=CWD<cr>", desc = "select file from root dir via frecency" },
      { ",C", "<cmd>Telescope frecency<cr>", desc = "select file via frecency" },
    },
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },
}
