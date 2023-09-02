return {
  {
    "junegunn/vim-easy-align",
    keys = { { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "alignment" } },
    opts = {},
  },
  {
    "kevinhwang91/nvim-bqf",
    dependencies = {
      "junegunn/fzf",
      build = function()
        vim.fn["fzf#install"]()
      end,
    },
    ft = "qf",
    opts = {},
  },
  {
    "dhruvasagar/vim-table-mode",
    cmd = "TableModeToggle",
    keys = "<leader>tm",
    config = function()
      -- regiter key group info for whichkey
      require("which-key").register({
        t = {
          -- optional group name
          name = "table mode",
          -- describe without creating keymaps
          d = "(table mode) delete row/col",
          i = "(table mode) insert row/col",
          f = "(table mode) formula",
        },
      }, { prefix = "<leader>" })
    end,
  },
}
