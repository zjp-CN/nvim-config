local translation = "translation(${1:path}): ${2:title}"
local luasnip_ = "luasnip(${1:filetype}): ${2:title}"
local update = "update(${1:something}): ${2:title}"
local update_ci = "update(ci): ${2:title}"

return {
  parse("translation", translation),
  parse("luasnip", luasnip_),
  parse("update", update),
  parse("update_ci", update_ci),
}
