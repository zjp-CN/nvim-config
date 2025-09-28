local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local enable_fancy_ui = false

return {
  { "LazyVim/LazyVim",              opts = { colorscheme = "catppuccin" } },
  -- { "catppuccin/nvim", enabled = true, name = "catppuccin", priority = 1000, opts = {} }, -- colorscheme
  {
    "folke/noice.nvim",
    enabled = enable_fancy_ui,
    opts = {
      presets = {
        bottom_search = true,    -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        lsp_doc_border = true,   -- add a border to hover docs and signature help
      },
      -- views = {
      --   popup = {
      --     win_options = {
      --       winhighlight = {
      --         Normal = "NormalFloat",
      --         FloatBorder = "FloatBorder",
      --       },
      --     },
      --   },
      -- },
    },
  },
  -- {
  --   "rcarriga/nvim-notify",
  --   enabled = enable_fancy_ui,
  --   ---@class notify.Config
  --   opts = {
  --     -- top_down = false, -- the position can only be top/bottom for now
  --     render = "compact",
  --     stages = "static",
  --   },
  -- },

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
    "nvim-lualine/lualine.nvim",
    opts = {
      -- options = { icons_enabled = false, theme = "nord" },
      sections = {
        lualine_b = {
          "branch",
          { "diff", source = diff_source },
        },
        lualine_c = {
          "diagnostics",
          { "filename", path = 1 },
        },
        lualine_x = {
          "encoding",
          "filetype",
          {
            "fileformat",
            icons_enabled = true,
            symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
          },
        },
        lualine_y = {},
        lualine_z = { "vim.fn.line('.') .. '/' .. vim.fn.line('$') .. ':' .. vim.fn.col('.')" },
      },
    },
  },
  -- color plugins
  { "NvChad/nvim-colorizer.lua",    event = { "BufReadPost", "BufNewFile" },  opts = {} },
  { "ziontee113/color-picker.nvim", cmd = { "PickColor", "PickColorInsert" }, opts = {} },
  -- floating terminal
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      notifier = { enabled = false },
      terminal = { win = { position = "float", border = "double" } },
    },
    keys = {
      { "<m-i>", "<cmd>lua Snacks.terminal()<cr>", mode = { "n" }, desc = "open float terminal" },
      { "<m-i>", "<cmd>close<cr>",                 mode = { "t" }, desc = "close (but not quit) float terminal" },
    },
  },
}
