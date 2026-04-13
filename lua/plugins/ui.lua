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

-- This avoids calling the statusline constantly by storing the instance only once.
local my_trouble_symbols = nil
local function get_symbols()
  if not my_trouble_symbols then
    local ok, trouble = pcall(require, "trouble")
    if ok then
      my_trouble_symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name}",
        hl_group = "lualine_x_normal",
      })
    end
  end
  return my_trouble_symbols
end

local enable_fancy_ui = false

return {
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
  -- { "catppuccin/nvim", enabled = true, name = "catppuccin", priority = 1000, opts = {} }, -- colorscheme
  {
    "folke/noice.nvim",
    enabled = enable_fancy_ui,
    opts = {
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        lsp_doc_border = true, -- add a border to hover docs and signature help
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
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>cs",
        "<cmd>Trouble lsp_document_symbols toggle win.type=split win.position=right win.size=0.5<cr>",
        desc = "Symbols (Trouble)",
      },
    },
  },
  {
    "catppuccin/nvim",
    opts = {
      custom_highlights = function(colors)
        return {
          TermCursor = { fg = colors.base, bg = colors.green },
          Cursor = { fg = colors.base, bg = colors.green },
        }
      end,
    },
  },

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
          {
            function()
              local s = get_symbols()
              return s and s.get() or ""
            end,
            cond = function()
              local s = get_symbols()
              return s and s.has() or false
            end,
            padding = { left = 1 },
          },
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
  { "NvChad/nvim-colorizer.lua", event = { "BufReadPost", "BufNewFile" }, opts = {} },
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
      { "<m-i>", "<cmd>close<cr>", mode = { "t" }, desc = "close (but not quit) float terminal" },
    },
  },
}
