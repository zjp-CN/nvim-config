return {
  {
    "mrcjkb/rustaceanvim",
    keys = {
      { "<F2>", "<cmd>RustLsp hover actions<cr>", ft = "rust", desc = "RustHoverActions" },
    },
    opts = {
      ---@type RustaceanToolsOpts
      tools = {
        test_executor = "termopen", -- default to a popup and hinder --nocapture arg
        -- enable_nextest = false, -- default is true
      },
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            ---@type _.lspconfig.settings.rust_analyzer.Hover
            hover = {
              show = {
                structFields = 20,
              },
            },
          },
        },
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
