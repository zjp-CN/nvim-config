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

local hash_branch = f(function(args)
  print(vim.inspect(args))
  local branch = args[1][1]
  if branch == '' then return '' end
  local hash = shell('git log --format="%h" -n 1 ' .. branch)
  if hash == '' then
    return ''
  else
    return '#' .. hash
  end
end, { 1 })
local master_failed = s("master_failed", {
  i(1, "master"), hash_branch
})
local master_ok = s("master_ok", {
  i(1, "master"), f(function(args)
    print(vim.inspect(args))
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

local branch_dyn = d(1, function()
  local output = shell 'git branch --format "%(refname:short)"'
  local choices = {}
  for branch in output:gmatch("[^ ]+") do
    table.insert(choices, t(branch))
  end
  return sn(nil, c(1, choices))
end, {})
local branch_failed = s("branch_failed", branch_dyn)
local branch_ok = s("branch_ok", d(1, function()
  local output = shell 'git branch --format "%(refname:short)"'
  local choices = {}
  for branch in output:gmatch("[^ ]+") do
    table.insert(choices, t(branch))
  end
  return sn(nil, c(1, choices))
end, {}))

local branch_hash = s("branch_hash", { branch_dyn, hash_branch })

return {
  githash, githash_master, githash_main, master_ok, branch_ok, branch_hash,
  master_failed, branch_failed,
}
