local fn = vim.fn

-- 检查是否安装 packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  local _ = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end
vim.cmd [[packadd packer.nvim]]

local packer = require 'packer'.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'tami5/lspsaga.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'

  -- Rust
  --use 'rust-lang/rust.vim'
  use 'simrat39/rust-tools.nvim'
  use 'Canop/nvim-bacon'
  use 'saecki/crates.nvim'

  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  -- Misc
  use 'folke/which-key.nvim'
  use 'windwp/nvim-autopairs'
  use 'nvim-lualine/lualine.nvim'
  use 'arkav/lualine-lsp-progress'
  use 'lewis6991/gitsigns.nvim'
  use 'petertriho/nvim-scrollbar'
  use 'kevinhwang91/nvim-hlslens'
  use 'liuchengxu/vista.vim'
  use 'sindrets/diffview.nvim'
  use 'tpope/vim-surround'
  use 'junegunn/vim-easy-align'

  use 'ldelossa/litee.nvim'
  use 'ldelossa/litee-calltree.nvim'
  use 'ldelossa/litee-symboltree.nvim'
  use 'ldelossa/litee-filetree.nvim'

  use 'godlygeek/tabular'
  use 'plasticboy/vim-markdown'
  use 'ap/vim-css-color'
  use 'preservim/nerdcommenter'
  use 'dhruvasagar/vim-table-mode'
  use 'mg979/vim-visual-multi'
  use 'rhysd/clever-f.vim'
  use 'azabiong/vim-highlighter'

  -- TODO
  use 'j-hui/fidget.nvim'
  use 'kevinhwang91/nvim-ufo'
  use 'rafcamlet/nvim-luapad'
end)

return packer
