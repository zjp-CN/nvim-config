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
  use 'sainnhe/sonokai'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'

  -- luasnip
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  -- Rust
  use 'rust-lang/rust.vim'
  use { 'simrat39/rust-tools.nvim', branch = 'modularize_and_inlay_rewrite' }
  use 'Canop/nvim-bacon'
  use 'saecki/crates.nvim'

  -- Debug
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  -- TreeSitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  -- Misc
  use 'folke/which-key.nvim'
  use 'windwp/nvim-autopairs'
  use 'petertriho/nvim-scrollbar'
  use 'kevinhwang91/nvim-hlslens'
  use 'liuchengxu/vista.vim'
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
  -- use 'mg979/vim-visual-multi'
  use 'rhysd/clever-f.vim'
  use 'azabiong/vim-highlighter'

  use 'j-hui/fidget.nvim'
  use 'SmiteshP/nvim-gps'
  use 'nvim-lualine/lualine.nvim'
  use 'arkav/lualine-lsp-progress'

  use 'Rykka/riv.vim'

  -- Describe the regular expression under the cursor
  use { 'bennypowers/nvim-regexplainer',
    config = function() require 'regexplainer'.setup() end,
    requires = { 'nvim-treesitter/nvim-treesitter', 'MunifTanjim/nui.nvim' }
  }

  -- TODO
  use 'kevinhwang91/nvim-ufo' -- fold: Not configured for now
  use 'rafcamlet/nvim-luapad'
end)

return packer
