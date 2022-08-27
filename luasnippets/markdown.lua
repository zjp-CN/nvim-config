local footnote = "[${1}]: ${2}"

local newline = t { "", "" }
local rust_ignore = s("rust_ignore", {
  t "```rust",
  c(1, {
    i(1, ",ignore"),
    t "",
  }),
  newline,
  i(2),
  newline,
  t { "```", "" },
  i(0),
})

local img_sized = '<img src="${1}" alt="${2}" width="${3}"/>'

return {
  parse("footnote", footnote),
  rust_ignore,
  parse("img_sized", img_sized),
}
