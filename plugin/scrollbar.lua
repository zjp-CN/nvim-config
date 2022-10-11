require "scrollbar".setup {
  show = false,
  handle = {
    text = " ",
  },
  marks = {
    Search = { color = "yellow", text = { "─", "━" } },
    Error = { color = "red", text = { "─", "━" } },
    Warn = { color = "orange", text = { "─", "━" } },
    Info = { color = "white", text = { "─", "━" } },
    Hint = { color = "white", text = { "─", "━" } },
    Misc = { color = "white", text = { "─", "━" } },
  },
}
require "scrollbar.handlers.search".setup {}
