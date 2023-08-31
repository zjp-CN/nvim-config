return {
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
}
