local M = {}
M.ra_json = 'rust-analyzer.json'
if M.user_ra_config then return M end

local is_windows = jit.os == 'Windows'
local function path_norm(path)
  return is_windows and path:gsub("/", "\\") or path
end

-- 解析 Json 配置文件
M.json_file = function(path)
  local path = path_norm(path)
  local file = io.open(path, 'rb')
  if not file then return nil end
  local content = file:read('*a')
  file:close()
  return vim.json.decode(content) or nil
end

-- table.is_empty
local function is_empty_table(t)
  return rawequal(next(t), nil)
end

-- 当前目录及其上级目录
-- path: "/tmp/nvim.root/uxwsBf/2_Luapad.lua"
-- paths: { "/tmp/nvim.root/uxwsBf/", "/tmp/nvim.root/", "/tmp/", "/" }
local function recur_dir(path)
  local split_path, paths = { '' }, {}
  for s in string.gmatch(path, '([^/]+)') do table.insert(split_path, s) end
  while not is_empty_table(split_path) do
    table.insert(paths, table.concat(split_path, '/') .. '/')
    table.remove(split_path)
  end
  return paths
end

-- 查找工作目录及其上级目录下的 ./settings/rust-analyzer.json 文件
local function settings_ra_config()
  local search_dirs = recur_dir(vim.fn.getcwd())
  for _, dir in ipairs(search_dirs) do
    local path = dir .. ".settings/" .. M.ra_json
    local user_ra_config_override = M.json_file(path)
    -- print(path, user_ra_config_override)
    if user_ra_config_override then
      return user_ra_config_override
    end
  end
  return nil
end

-- 如果项目目录中有 `.settings/rust-analyzer.json` 文件，则直接使用
local user_ra_config_override = settings_ra_config()
if user_ra_config_override then
  M.user_ra_config = user_ra_config_override
else
  -- 如果项目目录中有 `.rust-analyzer.json` 或 `rust-analyzer.json` 文件，则优先使用（合并 nvim 下的配置）
  local config_home = vim.fn.stdpath 'config' or "../../"
  M.user_ra_config = M.json_file(config_home .. (is_windows and '/' or '/nvim/') .. M.ra_json) or {}
  local user_ra_config = M.json_file('.' .. M.ra_json) or M.json_file(M.ra_json) or {}
  for key, value in pairs(user_ra_config) do
    M.user_ra_config[key] = value
  end
end
-- print(path_norm(vim.fn.stdpath 'config' .. (is_windows and '/' or '/nvim/') .. M.ra_json))
-- print(vim.inspect(M.user_ra_config))

return M
