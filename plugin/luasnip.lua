local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local l = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

local function reused_func(_, _, user_arg1)
  return user_arg1
end

local function count(_, _, old_state)
  old_state = old_state or {
    updates = 0
  }

  old_state.updates = old_state.updates + 1

  local snip = sn(nil, {
    t(tostring(old_state.updates))
  })

  snip.old_state = old_state
  return snip
end

local function simple_restore(args, _)
  return sn(nil, { i(1, args[1]), i(2, "user_text") })
end

local function simple_restore(args, _)
  return sn(nil, { i(1, args[1]), r(2, "dyn", i(nil, "user_text")) })
end

ls.add_snippets("all", {
  s("ternary", {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
  }),
  s("trigger", {
    i(1, "First jump"),
    t(" :: "),
    sn(2, {
      i(1, "Second jump"),
      t " : ",
      i(2, "Third jump")
    })
  }),
  s("trig", {
    i(1),
    f(
      function(args, snip, user_arg_1) return user_arg_1 .. args[1][1] end,
      { 1 },
      { user_args = { "Will be appended to text from i(0)", "aabb" } }
    ),
    i(0)
  }),
  s("trig2", {
    f(reused_func, {}, { user_args = { "text " } }),
    f(reused_func, {}, { user_args = { "different text" } }),
  }),
  s({ trig = "b(%d)", regTrig = true },
    f(function(args, snip) return "Captured Text: " .. snip.captures[1] .. "."
    end, {})
  ),
  s("trig3", {
    i(1, "text_of_first "),
    i(2, { "first_line_of_second", "second_line_of_second" }),
    -- order is 2,1, not 1,2!!
    f(function(args, snip)
      return " end"
    end, { 2, 1 })
  }),
  s("trig4", {
    i(1, "text_of_first "),
    i(2, { "first_line_of_second", "second_line_of_second", "" }),
    -- order is 2,1, not 1,2!!
    f(function(args, snip)
      return args[1][1] .. " " .. args[1][2] .. args[2][1] .. " end"
    end, { 2, 1 })
  }),
  s("trig5", {
    i(1, " text_of_first "),
    i(2, { " first_line_of_second ", " second_line_of_second " }),
    f(function(args, snip)
      return args[1][1] .. args[1][2] .. args[2][1]
    end, { ai[2], ai[1] }) }),
  postfix(".br", {
    f(function(_, parent)
      return "[" .. parent.snippet.env.POSTFIX_MATCH .. "]"
    end, {}),
  }),
  postfix(".brl", {
    l("[" .. l.POSTFIX_MATCH .. "]"),
  }),
  postfix(".brd", {
    d(1, function(_, parent)
      return sn(nil, { t("[" .. parent.env.POSTFIX_MATCH .. "]") })
    end)
  }),
  s("trig6", c(1, {
    t("Ugh boring, a text node"),
    i(nil, "At least I can edit something now..."),
    f(function(args) return "Still only counts as text!!" end, {})
  })),
  s("trig7", sn(1, {
    t("basically just text "),
    i(1, "And an insertNode.")
  })),
  s("isn", {
    isn(1, {
      t({ "This is indented as deep as the trigger",
        "and this is at the beginning of the next line" })
    }, "")
  }),
  s("isn2", {
    isn(1, t({ "//This is", "A multiline", "comment" }), "$PARENT_INDENT//")
  }),
  s("trig8", {
    t "text: ", i(1), t { "", "copy: " },
    d(2, function(args)
      -- the returned snippetNode doesn't need a position; it's inserted
      -- "inside" the dynamicNode.
      return sn(nil, {
        -- jump-indices are local to each snippetNode, so restart at 1.
        i(1, args[1])
      })
    end,
      { 1 })
  }),
  s("trig9", {
    i(1, "change to update"),
    d(2, count, { 1 })
  }),
  s("paren_change", {
    c(1, {
      sn(nil, { t("("), r(1, "user_text"), t(")") }),
      sn(nil, { t("["), r(1, "user_text"), t("]") }),
      sn(nil, { t("{"), r(1, "user_text"), t("}") }),
    }),
  }, {
    stored = {
      user_text = i(1, "default_text")
    }
  }),
  s("rest", {
    i(1, "preset"), t { "", "" },
    d(2, simple_restore, 1)
  }),
  s("rest2", {
    i(1, "preset"), t { "", "" },
    d(2, simple_restore, 1)
  }),
  s("trig_ai", {
    i(1), c(2, {
      sn(nil, {
        t "cannot access the argnode :(",
        f(function(args) return args[1] end, { 1 })
      }),
      t "sample_text"
    })
  }),
  s("trig_ai2", {
    i(1), c(2, {
      sn(nil, {
        t "can access the argnode :)",
        f(function(args) return args[1] end, { ai[1] })
      }),
      t "sample_text"
    })
  }),
})
