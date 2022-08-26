local translation = "translation(${1:path}): ${2:title}"
local luasnip_ = "luasnip(${1:filetype}): ${2:title}"

return {
  parse("translation", translation),
  parse("luasnip", luasnip_),
}
