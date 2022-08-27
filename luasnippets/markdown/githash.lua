-- execute bash cmd
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
local current_branch_hash = s("current_branch_hash", f(function()
  return shell 'git branch --show-current' .. '#' .. shell 'git log --format="%h" -n 1'
end))

-- helper for latest commit generation
local hash = function(branch)
  if branch == '' then return '' end
  local hash = shell('git log --format="%h" -n 1 ' .. branch)
  if hash == '' then
    return ''
  else
    return '#' .. hash
  end
end
-- <!-- master#18d2877 --->
local master = s("master", { f(function() return '<!-- master' .. hash('master') .. ' --->' end), t { "", "" } })
-- master#18d2877
local master_hash = s("master_hash", f(function() local b = "master" return b .. hash(b) end))
-- main#18d2877
local main_hash = s("main_hash", f(function() local b = "main" return b .. hash(b) end))

-- main#18d2877 or master#18d2877 or current_branch#18d2877
local hashtag = s("hashtag", f(function()
  local main = main_hash:get_docstring()[1]:sub(1, -3)
  if main ~= "main" then return main end
  local m = master_hash:get_docstring()[1]:sub(1, -3)
  if m ~= "master" then return m end
  return current_branch_hash:get_docstring()[1]:sub(1, -3)
end))

-- search for branches
local branches = function()
  local output = shell 'git branch --format "%(refname:short)"'
  local choices = {}
  for branch in output:gmatch("[^ ]+") do
    table.insert(choices, t(branch))
  end
  return choices
end
-- select a branch
local branch = s("branch", d(1, function() return sn(nil, c(1, branches())) end, {}))
-- select a branch with hash
local branch_hash = s("branch_hash", {
  d(1, function() return sn(nil, c(1, branches())) end),
  f(function(args) return hash(args[1][1]) end, 1)
})

return {
  current_branch_hash, master, master_hash, main_hash, branch, branch_hash, hashtag,
}
