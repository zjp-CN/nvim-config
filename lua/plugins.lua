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
  use { 'nvim-tree/nvim-web-devicons',
    config = function() require 'nvim-web-devicons'.setup {} end
  }
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope.nvim'
  use {
    "ErichDonGubler/lsp_lines.nvim",
    -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function() require("lsp_lines").setup() end,
  }
  use 'ray-x/lsp_signature.nvim'
  -- use 'lvimuser/lsp-inlayhints.nvim'

  -- telescope
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'kkharji/sqlite.lua'
  use { 'nvim-telescope/telescope-frecency.nvim', requires = { 'kkharji/sqlite.lua' } }
  use { 'nvim-telescope/telescope-smart-history.nvim', requires = { 'kkharji/sqlite.lua' } }

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  -- use 'hrsh7th/cmp-nvim-lsp-signature-help'

  -- luasnip
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use { 'danymat/neogen', requires = 'nvim-treesitter/nvim-treesitter' }

  -- Rust
  use 'rust-lang/rust.vim'
  use 'simrat39/rust-tools.nvim'
  -- use 'simrat39/symbols-outline.nvim'
  -- use '/root/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim'
  use 'stevearc/aerial.nvim'
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
  use { 'akinsho/git-conflict.nvim', tag = "*", }

  -- Misc
  use 'folke/which-key.nvim'
  use 'windwp/nvim-autopairs'
  use 'petertriho/nvim-scrollbar'
  use 'kevinhwang91/nvim-hlslens'
  use 'liuchengxu/vista.vim'
  use 'tpope/vim-surround'
  use 'junegunn/vim-easy-align'

  use 'godlygeek/tabular'
  use 'plasticboy/vim-markdown'
  use 'norcalli/nvim-colorizer.lua'
  use 'preservim/nerdcommenter'
  use 'dhruvasagar/vim-table-mode'
  -- use 'mg979/vim-visual-multi'
  use 'rhysd/clever-f.vim'
  use 'azabiong/vim-highlighter'

  use { 'j-hui/fidget.nvim', tag = 'legacy' } -- the plugin is rewriting
  use 'nvim-lualine/lualine.nvim'
  use 'arkav/lualine-lsp-progress'

  use 'Rykka/riv.vim'

  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }

  use 'numToStr/FTerm.nvim'
  use 'folke/todo-comments.nvim'
  use 'folke/trouble.nvim'
  use 'olimorris/persisted.nvim'

  -- TODO
  use 'kevinhwang91/nvim-ufo' -- fold: Not configured for now
  use 'rafcamlet/nvim-luapad'

  use 'zhenyangze/vim-bitoai'

end)

return packer
