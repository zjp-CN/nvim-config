return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
        mappings = {
          ["Z"] = "expand_all_nodes",
          ["C"] = "close_all_subnodes",
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    ---@class notify.Config
    opts = {
      -- top_down = false, -- the position can only be top/bottom for now
      render = "compact",
      stages = "static",
    },
  },
}
