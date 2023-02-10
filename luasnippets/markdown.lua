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

local function dt()
  return os.date('%Y-%m-%d %H:%M:%S', os.time()) .. ' +0800'
end

local datetimezone = s("datetimezone", f(dt, {}, {}))

local img_sized = '<img src="${1}" alt="${2}" width="${3}"/>'

local details = [[
<details>
  <summary>${1}</summary>
  
  ${0}
</details>
]]

local a_tag = '<a name="${1:tag}"></a>'

local twin_new = [[
<h3 id="new-$1">
    <a href="#new-$1">
        <span class="icon-text">
            <span class="icon">
                <i class="fa-solid fa-book"></i>
            </span>
            <span>$1</span>
        </span>
    </a>
</h3>

$0

---

]]

local twin_update = [[
<h3 id="update-$1">
  <a href="#update-$1">
    <span class="icon-text">
      <span class="icon">
        <i class="fa-solid fa-book"></i>
      </span>
      <span>$1</span>
    </span>
  </a>
</h3>

$0

---

]]

return {
  parse("footnote", footnote),
  rust_ignore,
  parse("img_sized", img_sized),
  datetimezone,
  parse("twin-new", twin_new),
  parse("twin-update", twin_update),
  parse("a_tag", a_tag),
  parse("details", details),
}
