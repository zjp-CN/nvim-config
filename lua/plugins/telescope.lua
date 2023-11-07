local on_windows = jit.os == "Windows"
local smart_history = on_windows
    and { history = { path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3", limit = 100 } }
  or {}

-- Declare the module
local telescopePickers = {}

-- Store Utilities we'll use frequently
local telescopeUtilities = require("telescope.utils")
local telescopeMakeEntryModule = require("telescope.make_entry")
local fileTypeIconWidth = 2
local tailPathWidth = 15
local parentPathWidth = 40
local telescopeEntryDisplayModule = require("telescope.pickers.entry_display")

-- Gets the File Path and its Tail (the file name) as a Tuple
function telescopePickers.getPathAndTail(fileName, len)
  -- Get the Tail
  local bufferNameTail = telescopeUtilities.path_tail(fileName)

  -- Now remove the tail from the Full Path
  local pathWithoutTail = require("plenary.strings").truncate(fileName, #fileName - #bufferNameTail, "")

  -- Apply truncation and other pertaining modifications to the path according to Telescope path rules
  local display = { "truncate" }
  if len and (#pathWithoutTail > len) then
    display = { shorten = { len = 1, exclude = { 1, -2, -1 } } }
  end
  -- display = len and { shorten = { len = 1, exclude = { 1, -1 } } } or { "shorten" }
  local pathToDisplay = telescopeUtilities.transform_path({
    path_display = display,
  }, pathWithoutTail)

  -- Return as Tuple
  return bufferNameTail, pathToDisplay
end

local kind_icons = {
  Text = "",
  String = "",
  Array = "",
  Object = "󰅩",
  Namespace = "",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰫧",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
  Copilot = "🤖",
  Boolean = "",
}

function telescopePickers.prettyDocumentSymbols(localOptions)
  if localOptions ~= nil and type(localOptions) ~= "table" then
    print("Options must be a table.")
    return
  end

  local options = localOptions or {}

  local originalEntryMaker = telescopeMakeEntryModule.gen_from_lsp_symbols(options)

  options.entry_maker = function(line)
    local originalEntryTable = originalEntryMaker(line)

    local displayer = telescopeEntryDisplayModule.create({
      separator = " ",
      items = {
        { width = fileTypeIconWidth },
        { width = 20 },
        { remaining = true },
      },
    })

    originalEntryTable.display = function(entry)
      return displayer({
        string.format("%s", kind_icons[(entry.symbol_type:lower():gsub("^%l", string.upper))]),
        { entry.symbol_type:lower(), "TelescopeResultsVariable" },
        { entry.symbol_name, "TelescopeResultsConstant" },
      })
    end

    return originalEntryTable
  end

  require("telescope.builtin").lsp_document_symbols(options)
end

function telescopePickers.prettyWorkspaceSymbols(localOptions)
  if localOptions ~= nil and type(localOptions) ~= "table" then
    print("Options must be a table.")
    return
  end

  local options = localOptions or {}

  local originalEntryMaker = telescopeMakeEntryModule.gen_from_lsp_symbols(options)

  options.entry_maker = function(line)
    local originalEntryTable = originalEntryMaker(line)

    local displayer = telescopeEntryDisplayModule.create({
      separator = " ",
      items = {
        { width = fileTypeIconWidth },
        { width = 15 },
        { width = 30 },
        { width = nil },
        { remaining = true },
      },
    })

    originalEntryTable.display = function(entry)
      local tail, _ = telescopePickers.getPathAndTail(entry.filename)
      local tailForDisplay = tail .. " "
      local pathToDisplay = telescopeUtilities.transform_path({
        path_display = { shorten = { num = 2, exclude = { -2, -1 } }, "truncate" },
      }, entry.value.filename)

      return displayer({
        string.format("%s", kind_icons[(entry.symbol_type:lower():gsub("^%l", string.upper))]),
        { entry.symbol_type:lower(), "TelescopeResultsVariable" },
        { entry.symbol_name, "TelescopeResultsConstant" },
        tailForDisplay,
        { pathToDisplay, "TelescopeResultsComment" },
      })
    end

    return originalEntryTable
  end

  require("telescope.builtin").lsp_dynamic_workspace_symbols(options)
end

function telescopePickers.prettyBuffersPicker(localOptions)
  if localOptions ~= nil and type(localOptions) ~= "table" then
    print("Options must be a table.")
    return
  end

  local options = localOptions or {}

  local originalEntryMaker = telescopeMakeEntryModule.gen_from_buffer(options)

  options.entry_maker = function(line)
    local originalEntryTable = originalEntryMaker(line)

    local displayer = telescopeEntryDisplayModule.create({
      separator = " ",
      items = {
        { width = fileTypeIconWidth },
        { width = nil },
        { width = nil },
        { remaining = true },
      },
    })

    originalEntryTable.display = function(entry)
      local tail, path = telescopePickers.getPathAndTail(entry.filename)
      local tailForDisplay = tail .. " "
      local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

      return displayer({
        { icon, iconHighlight },
        tailForDisplay,
        { "(" .. entry.bufnr .. ")", "TelescopeResultsNumber" },
        { path, "TelescopeResultsComment" },
      })
    end

    return originalEntryTable
  end

  require("telescope.builtin").buffers(options)
end

function telescopePickers.longPath(gen)
  local options = {}

  local originalEntryMaker = gen(options)

  options.entry_maker = function(line)
    local originalEntryTable = originalEntryMaker(line)
    local parent = parentPathWidth
    local limit = vim.fn.winwidth(0) / 3
    local displayer = telescopeEntryDisplayModule.create({
      separator = "│",
      items = {
        { width = tailPathWidth + fileTypeIconWidth + 1 },
        { width = parent < limit and parent or limit },
        { width = 6 },
        { remaining = true },
      },
    })

    originalEntryTable.display = function(entry)
      local tail, path = telescopePickers.getPathAndTail(entry.filename, parentPathWidth)
      local icon, iconHighlight = telescopeUtilities.get_devicons(tail)
      return displayer({
        { icon .. " " .. tail, iconHighlight },
        { path, "NonText" },
        { entry.lnum .. ":" .. entry.col, "NonText" },
        entry.text,
      })
    end

    return originalEntryTable
  end

  return options
end

local gen_from_buffer = telescopeMakeEntryModule.gen_from_quickfix
function telescopePickers.lsp_incoming_calls()
  require("telescope.builtin").lsp_incoming_calls(telescopePickers.longPath(gen_from_buffer))
end
function telescopePickers.lsp_outgoing_calls()
  require("telescope.builtin").lsp_outgoing_calls(telescopePickers.longPath(gen_from_buffer))
end
function telescopePickers.lsp_references()
  require("telescope.builtin").lsp_references(telescopePickers.longPath(gen_from_buffer))
end

local gen_from_vimgrep = telescopeMakeEntryModule.gen_from_vimgrep
function telescopePickers.live_grep()
  require("telescope.builtin").live_grep(telescopePickers.longPath(gen_from_vimgrep))
end
function telescopePickers.grep_string()
  require("telescope.builtin").grep_string(telescopePickers.longPath(gen_from_vimgrep))
end

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { ",r", telescopePickers.lsp_references },
      -- general keymap: builtin
      { ",t", "<cmd>Telescope<cr>" },
      -- { ",l", "<cmd>Telescope live_grep<cr>" },
      { ",l", telescopePickers.live_grep },
      -- { ",g", "<cmd>Telescope grep_string<cr>" },
      { ",g", telescopePickers.grep_string },
      { ",f", "<cmd>Telescope find_files<cr>" },
      { ",F", "<cmd>Telescope find_files no_ignore=true<cr>" },
      { ",h", "<cmd>Telescope highlights<cr>" },
      { ",,", "<cmd>Telescope help_tags<cr>" },
      { ",k", "<cmd>Telescope keymaps<cr>" },
      -- { ",b", "<cmd>Telescope buffers<cr>" },
      { ",b", telescopePickers.prettyBuffersPicker },
      { ",B", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
      { ",q", "<cmd>Telescope quickfix<cr>" },
      { ",Q", "<cmd>Telescope quickfixhistory<cr>" },
      { ",x", "<cmd>Telescope commands<cr>" },

      -- lsp keymaps
      { ",d", "<cmd>Telescope diagnostics layout_strategy=vertical<cr>", desc = "(lsp) Telescope diagnostics" },
      -- { ",D", "<cmd>Telescope lsp_document_symbols<cr>", desc = "(lsp) Telescope lsp_document_symbols" },
      { ",D", telescopePickers.prettyDocumentSymbols, desc = "(lsp) Telescope lsp_document_symbols" },
      {
        ",S",
        "<cmd>Telescope lsp_workspace_symbols<cr>",
        desc = "(lsp) Telescope lsp_workspace_symbols (in current workspace)",
      },
      {
        ",s",
        telescopePickers.prettyWorkspaceSymbols,
        -- "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "(lsp) Telescope lsp_dynamic_workspace_symbols (in all workspaces)",
      },
      -- { ",i", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "(lsp) Telescope lsp_incoming_calls" },
      { ",i", telescopePickers.lsp_incoming_calls, desc = "(lsp) Telescope lsp_incoming_calls" },
      -- { ",o", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "(lsp) Telescope lsp_outgoing_calls" },
      { ",o", telescopePickers.lsp_outgoing_calls, desc = "(lsp) Telescope lsp_outgoing_calls" },
      { ",T", "<cmd>Telescope lsp_type_definitions<cr>", desc = "(lsp) Telescope lsp_type_definitions" },
      { ",I", "<cmd>Telescope lsp_implementations<cr>", desc = "(lsp) Telescope lsp_implementations" },
    },
    opts = function(_, opts)
      -- opts.defaults.path_display = { shorten = { len = 1, exclude = { 1, -1 } } }
      -- opts.defaults.path_display = { truncate = 3 }
      -- ## layout
      opts.defaults.layout_strategy = "vertical"
      opts.defaults.layout_config = {
        vertical = { width = 0.99, height = 0.95, prompt_position = "top" },
        horizontal = { width = 0.99, height = 0.95, prompt_position = "bottom", preview_cutoff = 10 },
      }

      -- ## keymapping
      local action = require("telescope.actions")
      local layout = require("telescope.actions.layout")
      local mappings = opts.defaults.mappings
      -- insert mode
      mappings.i = vim.tbl_extend("force", mappings.i, {
        ["<C-f>"] = action.to_fuzzy_refine, -- fuzzy search in live_grep
      })
      -- normal mode
      mappings.n = vim.tbl_extend("force", mappings.n, {
        ["t"] = action.toggle_all,
        ["T"] = action.drop_all,
        ["d"] = action.delete_buffer,
        -- `<C-q>` clear + send all to quickfix
        -- `<A-q>` clear + send the selected to quickfix
        -- `a` add the selected to quickfix
        -- `A` add all to quickfix
        ["M-a"] = action.add_selected_to_qflist,
        ["C-A"] = action.add_to_qflist,
        ["l"] = layout.cycle_layout_next,
        ["p"] = layout.toggle_preview,
        ["<C-f>"] = action.to_fuzzy_refine, -- fuzzy search in live_grep
      })
      return opts
    end,
  },
  -- dependency for plugins
  {
    "kkharji/sqlite.lua",
    config = function()
      if on_windows then
        vim.g.sqlite_clib_path = "E://Programming//sqlite3//sqlite3.dll"
      end
    end,
  },
  -- classify histories in Telescope
  {
    "nvim-telescope/telescope-smart-history.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
      {
        "nvim-telescope/telescope.nvim",
        opts = { defaults = smart_history },
      },
    },
    ft = "TelescopePrompt",
    config = function()
      require("telescope").load_extension("smart_history")
    end,
  },
  -- alternative to neotree, but always works
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    cmd = "Telescope file_browser",
    keys = {
      { "<space>f", "<cmd>Telescope file_browser<cr>", desc = "browser files in root dir" },
      {
        "<space>F",
        '<cmd>lua require"telescope".extensions.file_browser.file_browser{path=vim.fn.expand"%:p:h"}<cr>',
        desc = "browser files in current dir",
      },
      {
        ";f",
        "<cmd>Telescope file_browser respect_gitignore=false<cr>",
        desc = "browser file in root dir without gitignore",
      },
      {
        ";F",
        '<cmd>lua require"telescope".extensions.file_browser.file_browser{path=vim.fn.expand"%:p:h", respect_gitignore=false}<cr>',
        desc = "browser file in current dir without gitignore",
      },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
  -- file history for selection & read
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    keys = {
      { ",c", "<cmd>Telescope frecency workspace=CWD<cr>", desc = "select file from root dir via frecency" },
      { ",C", "<cmd>Telescope frecency<cr>", desc = "select file via frecency" },
    },
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },
}
