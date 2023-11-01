return {
  {
    "simrat39/rust-tools.nvim",
    keys = {
      { "<F2>", "<cmd>RustHoverActions<cr>", desc = "RustHoverActions" },
    },
    opts = {
      tools = {
        inlay_hints = { auto = false },
      },
    },
  },
  {
    "Saecki/crates.nvim",
    keys = {
      { "<F4>", "<cmd>lua require('crates').show_features_popup()<cr>", desc = "crates: show_features_popup" },
      { "<F5>", "<cmd>lua require('crates').show_popup()<cr>", desc = "crates: show_popup" },
      { "<F6>", "<cmd>lua require('crates').show_dependencies_popup()<cr>", desc = "crates: show_dependencies_popup" },
    },
  },
}
