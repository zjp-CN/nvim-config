local insert_middle = s("trig", { t "... ", i(1, ""), t " ..." })

return {
  parse("ctrig", "also loaded!!$1xxx"),
  parse("ctrig2", "also loaded2!!"),
  parse("nested", "... ${1:this is ${2:nested}} ..."),
  parse("insert_middle", table.concat(insert_middle:get_docstring())),
  -- parse("insert_middle", gen(insert_middle)),
}, {
  parse("autotrig", "autotriggered, if enabled")
}
