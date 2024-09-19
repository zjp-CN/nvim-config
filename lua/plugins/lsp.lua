-- :h lspconfig-global-defaults (override global defaults for all servers)
-- Don't autostart when opening a file, manually call `:LspStart` instead.
-- But this snippet increase startup time by 30ms (up to 10% of total startup time),
-- so write it in config for each lsp to save startup time.
-- local lspconfig = require("lspconfig")
-- lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
--   autostart = false,
-- })

return {
  -- basic config
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
      ui = {
        windows = {
          default_options = {
            border = "rounded", -- make border rounded
          },
        },
      },
      servers = {
        -- ["rust_analyzer"] = { autostart = false }, -- rustaceanvim doesn't use lspconfig
        ["taplo"] = { autostart = false },
        ["lua_ls"] = { autostart = true },

        -- typst1
        -- ["typst_lsp"] = {
        --   exportPdf = "onType", -- Choose onType, onSave or never.
        --   -- serverPath = "" -- Normally, there is no need to uncomment it.
        -- },
        -- typst2
        tinymist = {
          --- todo: these configuration from lspconfig maybe broken
          single_file_support = true,
          root_dir = function()
            return vim.fn.getcwd()
          end,
          --- See [Tinymist Server Configuration](https://github.com/Myriad-Dreamin/tinymist/blob/main/Configuration.md) for references.
          settings = {},
        },
      },
      format = {
        filter = function(client)
          -- skip formatting due to some bug
          return client.name ~= "tsserver" or client.name ~= "volar"
        end,
      },
    },
  },
  -- ui
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
  -- sidebar symbol tree
  {
    "stevearc/aerial.nvim",
    opts = {
      layout = {
        -- default_direction = "float",
        placement = "edge",
        min_width = { 40, 0.4 },
      },
      nerd_font = false,
      close_on_select = true,
      show_guides = true,
      float = {
        relative = "win",
        min_height = { 8, 0.5 },
      },
      backends = { "lsp", "treesitter", "markdown", "man" },
      filter_kind = false,
    },
    keys = {
      { "<space>t", "<cmd>AerialToggle<cr>", desc = "toggle aerial (sidebar symbol tree)" },
      { "<space>T", "<cmd>Telescope aerial<cr>", desc = "open aerial in Telescope" },
    },
  },
}
