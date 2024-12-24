-- default to use listed buffers as a source for nvim-cmp
vim.g.cmp_get_bufnrs = "buflisted"

local function sql_formatter_config()
  local json = "/lua/plugins/sql_formatter.json"
  local path = (jit.os == "Linux") and json or json:gsub("/", "\\")
  return vim.fn.stdpath("config") .. path
end

local snippet_path = vim.fn.stdpath("config") .. "/snippets"

-- change buffers source in nvim-cmp
local get_bufnrs = function()
  local cmp_get_bufnrs = vim.g.cmp_get_bufnrs
  local api = vim.api
  local bufs = {}

  --  current buffer
  if cmp_get_bufnrs == "current_buf" then
    table.insert(bufs, api.nvim_get_current_buf())
    return bufs
  end

  -- buffers in current tab including unlisted ones like help
  if cmp_get_bufnrs == "current_tab" then
    for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
      table.insert(bufs, api.nvim_win_get_buf(win))
    end
    return bufs
  end

  -- all active/listed non-empty buffers
  -- or all buffers including hidden/unlisted ones (like help/terminal)
  for _, buf in ipairs(api.nvim_list_bufs()) do
    if
      (
        cmp_get_bufnrs == "buflisted" and api.nvim_get_option_value("buflisted", { buf = buf })
        or cmp_get_bufnrs == "all"
      )
      and api.nvim_buf_is_loaded(buf)
      and api.nvim_buf_line_count(buf) > 0
    then
      table.insert(bufs, buf)
    end
  end

  return bufs
end

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
      vim.g.table_mode_corner = "|"
      -- regiter key group info for whichkey
      require("which-key").add({
        { "<leader>t", group = "table mode" },
        { "<leader>td", desc = "(table mode) delete row/col" },
        { "<leader>tf", desc = "(table mode) formula" },
        { "<leader>ti", desc = "(table mode) insert row/col" },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zjp-CN/nvim-cmp-lsp-rs",
        -- dir = "/rust/github/nvim-cmp-lsp-rs",
        -- dependencies = { "hrsh7th/nvim-cmp" },
        -- opts = {},
        --@param opts cmp_lsp_rs.Opts
        -- config = function(_, opts)
        --   require("cmp_lsp_rs").setup(opts)
        -- end,
        -- event = { "InsertEnter" },
        -- main = "cmp_lsp_rs",
      },
    },
    keys = {
      { "<leader>b0", "<cmd>let g:cmp_get_bufnrs='current_buf'<cr>", desc = "(nvim-cmp) cmp_get_bufnrs='current_buf'" },
      { "<leader>b1", "<cmd>let g:cmp_get_bufnrs='current_tab'<cr>", desc = "(nvim-cmp) cmp_get_bufnrs='current_tab'" },
      { "<leader>b2", "<cmd>let g:cmp_get_bufnrs='buflisted'<cr>", desc = "(nvim-cmp) cmp_get_bufnrs='buflisted'" },
      { "<leader>ba", "<cmd>let g:cmp_get_bufnrs='current_buf'<cr>", desc = "(nvim-cmp) cmp_get_bufnrs='all'" },
      { "<leader>bc", "<cmd>lua require'cmp_lsp_rs'.combo()<cr>", desc = "(nvim-cmp) switch comparators" },
    },
    --@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local compare = require("cmp").config.compare

      -- disable auto select: always select first candidate instead
      opts.preselect = cmp.PreselectMode.None

      -- opts.view = vim.tbl_deep_extend("keep", opts.view or {}, {
      --   docs = { auto_open = false },
      -- })

      local cmp_rs = require("cmp_lsp_rs")
      local comparators = cmp_rs.comparators

      opts.sorting.comparators = {
        -- compare.kind,
        -- comparators.inherent_import_inscope,
        -- comparators.inscope_inherent,
        compare.recently_used,
        compare.exact,
        compare.score,
        comparators.inherent_import_inscope,
        -- comparators.inscope_inherent_import,
        comparators.sort_by_label_but_underscore_last,
        -- compare.sort_text,
      }

      for _, source in ipairs(opts.sources) do
        if source.name == "buffer" then
          source.option = vim.tbl_deep_extend("keep", { get_bufnrs = get_bufnrs }, source.option or {})
        end

        cmp_rs.filter_out.entry_filter(source)
      end
      return opts
    end,
  },
  {
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      opts = { ensure_installed = { "sql-formatter" } },
    },
    opts = {
      formatters_by_ft = {
        sql = { "sql_formatter" },
        sh = { "shfmt" },
        typst = { "typstyle" },
        -- rust = { "rustfmt" },
      },
      formatters = {
        sql_formatter = { prepend_args = { "--config", sql_formatter_config() } },
        shfmt = { prepend_args = { "-i", "2" } },
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {
      default = { replace = { cmd = "oxi" } },
    },
  },
  -- disable friendly-snippets
  { "rafamadriz/friendly-snippets", enabled = false },
  -- better editing and creation of snippets (based on LuaSnip)
  {
    "chrisgrieser/nvim-scissors",
    dependencies = {
      "L3MON4D3/LuaSnip",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippet_path } })
      end,
    },
    keys = {
      {
        "<space>e",
        function()
          require("scissors").editSnippet()
        end,
        desc = "edit snippet",
      },
      {
        "<space>a",
        function()
          require("scissors").addNewSnippet()
        end,
        mode = { "n", "x" },
        desc = "add snippet",
      },
    },
    event = "VeryLazy",
    opts = {
      snippetDir = snippet_path,
      editSnippetPopup = {
        height = 0.5, -- relative to the window, number between 0 and 1
        width = 0.5,
        border = "rounded",
        keymaps = {
          cancel = "q",
          saveChanges = "<CR>", -- alternatively, can also use `:w`
          goBackToSearch = "<BS>",
          deleteSnippet = "<C-d>",
          duplicateSnippet = "<C-y>",
          openInFile = "<C-f>",
          insertNextPlaceholder = "<C-n>", -- insert & normal mode
          -- jumpBetweenBodyAndPrefix = "<C-a>", -- insert & normal mode
        },
      },
    },
  },
  {
    "jbyuki/venn.nvim",
    cmd = "VBox",
    keys = {
      {
        "<space>v",
        function()
          local venn_enabled = vim.inspect(vim.b.venn_enabled)
          if venn_enabled == "nil" then
            vim.b.venn_enabled = true
            vim.cmd([[setlocal ve=all]])
            -- draw a line
            vim.api.nvim_buf_set_keymap(0, "n", "<down>", "<C-v>j:VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "n", "<up>", "<C-v>k:VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "n", "<right>", "<C-v>l:VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "n", "<left>", "<C-v>h:VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(
              0,
              "n",
              "f",
              "i <C-c>vy100pVy50pggg0<cmd>mapclear <buffer> | unlet b:venn_enabled<cr>",
              { noremap = true, desc = "Fill the buffer with 100*50 empty chars and disable venn" }
            )
            -- draw a box
            vim.api.nvim_buf_set_keymap(0, "v", "b", ":VBox<CR>", { noremap = true })
            print("Venn plotting starts.")
          else
            vim.cmd([[setlocal ve=]])
            vim.cmd([[mapclear <buffer>]])
            vim.b.venn_enabled = nil
            print("Venn plotting stops.")
          end
        end,
        mode = { "n" },
        desc = "Toggle venn plotting",
      },
      { "<space>b", ":VBox<cr>", mode = "v", desc = "Plot a Box on selected content" },
    },
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.comment",
    opts = {
      options = {
        -- Function to compute custom 'commentstring' (optional)
        custom_commentstring = function()
          if vim.bo.filetype == "typst" then
            return "// %s"
          end
        end,
      },
    },
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}
