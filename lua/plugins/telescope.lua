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

      -- lsp keymaps
      { ",d", "<cmd>Telescope diagnostics layout_strategy=vertical<cr>", desc = "(lsp) Telescope diagnostics" },
      { ",D", "<cmd>Telescope lsp_document_symbols<cr>", desc = "(lsp) Telescope lsp_document_symbols" },
      { ",s", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "(lsp) Telescope lsp_workspace_symbols" },
      {
        ",S",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "(lsp) Telescope lsp_dynamic_workspace_symbols",
      },
      { ",i", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "(lsp) Telescope lsp_incoming_calls" },
      { ",o", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "(lsp) Telescope lsp_outgoing_calls" },
      { ",T", "<cmd>Telescope lsp_type_definitions<cr>", desc = "(lsp) Telescope lsp_type_definitions" },
      { ",I", "<cmd>Telescope lsp_implementations<cr>", desc = "(lsp) Telescope lsp_implementations" },
    },
  },
  -- dependency for plugins
  {
    "kkharji/sqlite.lua",
    config = function()
      if on_windows then
        vim.g.sqlite_clib_path = "E://Programming//sqlite3//sqlite3.dll"
      end
    end,
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
    ft = "TelescopePrompt",
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
    dependencies = { "kkharji/sqlite.lua" },
    keys = {
      { ",c", "<cmd>Telescope frecency workspace=CWD<cr>", desc = "select file from root dir via frecency" },
      { ",C", "<cmd>Telescope frecency<cr>", desc = "select file via frecency" },
    },
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },
}
