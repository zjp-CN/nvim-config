return {
  name = "cargo miri test",
  builder = function()
    return { cmd = "cargo", args = { "miri", "test" } }
  end,
  condition = { filetype = { "rust" } },
}
