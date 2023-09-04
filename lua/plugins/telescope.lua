local tele = require("telescope")

return {
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
      tele.load_extension("file_browser")
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = {
      {
        "kkharji/sqlite.lua",
        config = function()
          if jit.os == "Windows" then
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
      tele.load_extension("frecency")
    end,
  },
}
