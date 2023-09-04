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
    keys = { { "<leader>tm", desc = "toggle table mode" } },
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
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      for i, item in ipairs(opts.sources) do
        for key, value in pairs(item) do
          if key == "name" and value == "buffer" then
            item["option"] = {
              get_bufnrs = function()
                local bufs = {}
                -- all buffers (maybe deleted buffers like help page)
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                  if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_line_count(buf) > 0 then
                    table.insert(bufs, buf)
                  end
                end
                -- buffers in current window/tab
                -- for _, win in ipairs(vim.api.nvim_list_wins()) do
                --   table.insert(bufs, vim.api.nvim_win_get_buf(win))
                -- end
                return bufs
              end,
            }
            goto continue
          end
        end
      end
      ::continue::
      return opts
    end,
  },
}
