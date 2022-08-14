local postfix = require "luasnip.extras.postfix".postfix

local bracketed = postfix({ trig = ".bk", name = "[...]", dscr = "[...]" }, {
  f(function(_, parent)
    return "[" .. parent.snippet.env.POSTFIX_MATCH .. "]"
  end, {}),
})

local braced = postfix({ trig = ".br", name = "{...}", dscr = "{...}" }, {
  f(function(_, parent)
    return "{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
  end, {}),
})

local parenthesized = postfix({ trig = ".p", name = "(...)", dscr = "(...)" }, {
  f(function(_, parent)
    return "(" .. parent.snippet.env.POSTFIX_MATCH .. ")"
  end, {}),
})

local angle_bracketed = postfix({ trig = ".a", name = "<...>", dscr = "<...>" }, {
  f(function(_, parent)
    return "<" .. parent.snippet.env.POSTFIX_MATCH .. ">"
  end, {}),
})

local code = postfix({ trig = ".c", name = "`...`", dscr = "`...`" }, {
  f(function(_, parent)
    return "`" .. parent.snippet.env.POSTFIX_MATCH .. "`"
  end, {}),
})


return {
  bracketed,
  braced,
  parenthesized,
  angle_bracketed,
  code,
}
