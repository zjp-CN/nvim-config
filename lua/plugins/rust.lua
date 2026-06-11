return {
  {
    "mrcjkb/rustaceanvim",
    keys = {
      { "<F2>", "<cmd>RustLsp hover actions<cr>", ft = "rust", desc = "RustHoverActions" },
      -- { "<space><space>", "<cmd>RustLsp flyCheck<cr>", ft = "rust", desc = "Rust Fly Check" },
    },
    opts = {
      tools = {
        test_executor = "termopen", -- default to a popup and hinder --nocapture arg
        enable_nextest = false, -- default is true
        -- float_win_config = { border = "double" },
      },
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = false },
            hover = {
              memoryLayout = { enable = true, niches = true, size = "both" },
              show = { fields = 50, enumVariants = 50 },
            },
            -- check = { command = "check" },
            checkOnSave = true,
            rustc = { source = "discover" },
            rustcSource = "discover", -- old settings in RA
          },
        },
        cmd_env = { RA_LOG = "error" },
        status_notify_level = false,
      },
    },
    config = function(_, opts)
      -- `<leader>rl` to toggle auto start rust-analyzer when opening a rs file.
      opts.server.auto_attach = vim.g.start_rust_lsp == true
      vim.g.rustaceanvim = opts
    end,
  },
  {
    "Saecki/crates.nvim",
    keys = {
      -- { "<F4>", "<cmd>lua require('crates').show_features_popup()<cr>", desc = "crates: show_features_popup" },
      -- { "<F5>", "<cmd>lua require('crates').show_popup()<cr>", desc = "crates: show_popup" },
      -- { "<F6>", "<cmd>lua require('crates').show_dependencies_popup()<cr>", desc = "crates: show_dependencies_popup" },
    },
  },
}
