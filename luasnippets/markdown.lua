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

local function shell(cmd)
  local f = io.popen(cmd .. ' 2>/dev/null', 'r') -- ignore errors
  if not f then return '' end
  local s = f:read('*a')
  f:flush()
  f:close()
  if not s then return '' end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

-- last hash of commit on current branch
-- print(os.execute 'git log --format="%h" -n 1')
local githash = s("githash",
  f(function() return shell 'git branch --show-current' .. '#' .. shell 'git log --format="%h" -n 1' end, {}))
-- last hash of commit on current branch
local githash_master = s("githash_master",
  f(function()
    local hash = shell 'git log --format="%h" -n 1 master'
    if hash == '' then
      return ''
    else
      return 'master#' .. hash
    end
  end, {}))
-- last hash of commit on current branch
local githash_main = s("githash_main",
  f(function()
    local hash = shell 'git log --format="%h" -n 1 main'
    if hash == '' then
      return ''
    else
      return 'main#' .. hash
    end
  end, {}))
local githash_branch = s("githash_branch", {
  i(1),
  f(function(args)
    local branch = args[1][1]
    if branch == '' then return '' end
    local hash = shell('git log --format="%h" -n 1 ' .. branch)
    if hash == '' then
      return ''
    else
      return '#' .. hash
    end
  end, { 1 })
})

local img_sized = '<img src="${1}" alt="${2}" width="${3}"/>'

return {
  parse("footnote", footnote),
  rust_ignore,
  parse("img_sized", img_sized),
  githash, githash_master, githash_main, githash_branch,
}
