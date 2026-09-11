-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- exchange default leader/localleader set by lazyvim
vim.g.mapleader = [[\]]
vim.g.localleader = [[<space>]]

-- Ubuntu local: sync with system clipboard
-- But shift+insert pastes primary buffer (copy content after mouse selection),
-- doesn't pastes the last user copied contents. So in local ubuntu terminal,
-- use ctrl+v or ctrl+shift+v (especially in neovim) to paste user contents.
vim.opt.clipboard = "unnamedplus"

-- vim.opt.clipboard = "" -- disable sync with system clipboard
-- Windows Terminal clipboard.
-- 1. Connect `y` the unnamed register with `+` the system clipboard.
-- -- 2. 手动封装 OSC 52 复制函数
-- local function osc52_copy(lines)
--   -- 1. 将多行内容合并，强制使用 \n 换行（符合 Linux/Unix 标准）
--   local s = table.concat(lines, "\n")
--
--   -- 2. Base64 编码
--   local b64 = vim.base64.encode(s)
--
--   -- 3. 彻底清除 Base64 字符串中的所有空格、换行符（防止断开转义序列）
--   b64 = b64:gsub("%s+", "")
--
--   local osc
--   if vim.env.TMUX then
--     -- 4. Tmux 专属的包装格式 (DCS 序列)
--     -- 注意：在 Tmux 中，内部的 ESC 必须写成 ESC ESC (\x1b\x1b)
--     -- 格式：ESC P tmux ; ESC ESC ] 52 ; c ; [B64] BEL ESC \
--     osc = string.format("\x1bPtmux;\x1b\x1b]52;c;%s\x07\x1b\\", b64)
--   else
--     -- 普通终端格式
--     osc = string.format("\x1b]52;c;%s\x07", b64)
--   end
--
--   -- 5. 使用 io.stderr 直接写入，并立即刷新缓冲区
--   io.stderr:write(osc)
--   io.stderr:flush()
-- end
-- -- 3. Custom clipboard channel.
-- vim.g.clipboard = {
--   name = "OSC 52",
--   copy = {
--     ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
--     -- ["+"] = osc52_copy,
--     -- ["*"] = osc52_copy,
--   },
--   paste = {
--     -- 关键：Windows Terminal 不支持远程读取剪贴板。
--     -- 这里设为从 Neovim 内部寄存器读取，防止 Neovim 因尝试访问终端剪贴板而卡顿/报错。
--     ["+"] = function()
--       return { vim.fn.getreg("+"), vim.fn.getregtype("+") }
--     end,
--     ["*"] = function()
--       return { vim.fn.getreg("*"), vim.fn.getregtype("*") }
--     end,
--   },
-- }

vim.g.lazyvim_picker = "telescope"

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.conceallevel = 0 -- no hidden symbols especially in markdown

-- enable undotree and map the key to open
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<space>u", require("undotree").open)

-- Restore jumping to next/previous diff location in diff mode. (TreeSitter overrides them.)
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    if vim.v.option_new == "true" or vim.wo.diff then
      vim.keymap.set("n", "]c", "]c", { buffer = true, desc = "Next diff location" })
      vim.keymap.set("n", "[c", "[c", { buffer = true, desc = "Previous diff location" })
    end
  end,
})

local border = "double"

-- vim.lsp.buf.hover({ border })
-- vim.lsp.buf.signature_help({ border })
vim.diagnostic.config({ float = { border } })

vim.lsp.config("*", {
  before_init = function(_, config)
    local codesettings = require("codesettings")
    codesettings.with_local_settings(config.name, config)
  end,
})

-- **************** safety-tool LSP config ****************
vim.lsp.config["safety-lsp"] = {
  -- Command and arguments to start the server.
  cmd = { "/home/gh-zjp-CN/tag-std/safety-tool/target/debug/safety-lsp" },
  -- Environment variables passed to the LSP process on spawn
  cmd_env = {
    SP_DISABLE_CHECK = 1,
    -- SP_FILE = "/home/gh-zjp-CN/tag-std/safety-tool/assets/sp-core.toml",
  },

  -- Filetypes to automatically attach to.
  filetypes = { "rust" },

  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { "Cargo.toml" }, ".git" },

  -- Specific settings to send to the server. The schema is server-defined.
  settings = {},
}
-- Make LSP server config into effects.
-- vim.lsp.enable("safety-lsp")
