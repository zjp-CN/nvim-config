local pfn = [[
${1|,pub ,pub(super) ,pub(crate) |}fn ${2:name}(${3})${5: -> ${6:Type}} {
    ${7:unimplemented!();}
}
]]

local tmp = s("pfn", {
  c(1, { t "", t "pub ", t "pub(super) ", t "pub(crate) ", }),
  t "fn ",
  i(2, "name"),
  t "(",
  c(3, { i(1, "args"), t "" }),
  t ")",
  c(4, {
    sn(1, { t "-> Result<", i(1, "T"), t ">" }),
    sn(2, { t "-> Option<", i(1, "T"), t ">" }),
    sn(3, { t "-> ", i(1, "T"), }),
    t "",
  }),
  t { " {", "    " },
  i(5, "todo!()"),
  t { "", "}" },
})

return {
  parse("pfn_", pfn),
  tmp,
}
