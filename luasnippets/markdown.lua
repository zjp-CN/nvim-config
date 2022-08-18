local footnote = "[${1}]: ${2}"

local newline = t { "", "" }
local rust_ignore = s("rust_ignore", {
  t "```rust",
  c(1, {
    t "",
    i(1, ",ignore"),
  }),
  newline,
  i(2),
  newline,
  t { "```", "" },
  i(0),
})

return {
  parse("footnote", footnote),
  rust_ignore,
}
