local aoc = [[
#[aoc]
pub mod tests {
    $1
}
]]
-- local pfn_ = [[
-- ${1|,pub ,pub(super) ,pub(crate) |}fn ${2:name}(${3})${5: -> ${6:Type}} {
--     ${7:unimplemented!();}
-- }
-- ]]

-- local pfn = s("pfn", {
--   c(1, { t "", t "pub ", t "pub(super) ", t "pub(crate) ", }),
--   t "fn ",
--   i(2, "name"),
--   t "(",
--   c(3, { i(1, "args"), t "" }),
--   t ")",
--   c(4, {
--     sn(nil, { t "-> Result<", i(1, "T"), t ">" }),
--     sn(nil, { t "-> Option<", i(1, "T"), t ">" }),
--     sn(nil, { t "-> ", i(1, "T"), }),
--     t "",
--   }),
--   t { " {", "    " },
--   i(5, "todo!()"),
--   t { "", "}", "" },
-- })

local tokio_main = [[
#[tokio::main]
async fn main() {
    ${0}
}
]]

local async_fn = [[
async fn ${1:name}() {
    ${0}
}
]]

return {
  parse("aoc", aoc),
  parse("tokio_main", tokio_main),
  parse("async_fn", async_fn),
}
