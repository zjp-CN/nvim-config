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
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "K", '<cmd>lua vim.lsp.buf.hover({border="double"})<cr>', "Hover" }

      local ret = {
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
            settings = {
              exportPdf = "never",
              -- exportPdf = "onType",
              -- outputPath = "$root/target/$dir/$name",
              outputPath = "$root/target/$dir_lsp",
            },
          },

          -- ref: https://github.com/LazyVim/LazyVim/pull/6238
          volar = { -- when LazyVim switches to nvim-lspconfig ≥ v2.2.0 rename this to `vue_ls`
            on_init = function(client)
              client.handlers["tsserver/request"] = function(_, result, context)
                -- find the vtsls client
                local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
                if #clients == 0 then
                  vim.notify("Could not find `vtsls` client, Vue LSP features will be disabled", vim.log.levels.ERROR)
                  return
                end
                local ts_client = clients[1]
                -- unpack the forwarded request
                local params = unpack(result)
                local id, command, payload = unpack(params)
                -- forward it
                ts_client:exec_cmd({
                  title = "vue_request_forward",
                  command = "typescript.tsserverRequest",
                  arguments = { command, payload },
                }, { bufnr = context.bufnr }, function(_, resp)
                  -- send the tsserver/response back to Vue LSP
                  client.notify("tsserver/response", { { id, resp.body } })
                end)
              end
            end,
          },
        },
      }

      return vim.tbl_deep_extend("force", opts, ret)
    end,
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
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      },
    },
  },
}
