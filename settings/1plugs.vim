" vim-plug 安装的插件

function Proxy(str)
let prefix = 'https://github.com.cnpmjs.org/'
  Plug  prefix . a:str . '.git'
endfunction

command! -nargs=1 Proxy :call Proxy(<args>)

call plug#begin(expand(stdpath('config')) . '/plugged')
" === https://sharksforarms.dev/posts/neovim-rust/ ===
" Collection of common configurations for the Nvim LSP client
Proxy 'neovim/nvim-lspconfig'

" Completion framework
Proxy 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Proxy 'hrsh7th/cmp-nvim-lsp'

" Snippet engine
Proxy 'hrsh7th/vim-vsnip'
" Snippet completion source for nvim-cmp
Proxy 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Proxy 'hrsh7th/cmp-path'
Proxy 'hrsh7th/cmp-buffer'
Proxy 'hrsh7th/cmp-cmdline'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Proxy 'simrat39/rust-tools.nvim'

" Fuzzy finder
" Optional
Proxy 'nvim-lua/popup.nvim'
Proxy 'nvim-lua/plenary.nvim'
Proxy 'nvim-telescope/telescope.nvim'

" Proxy 'glepnir/lspsaga.nvim'
Proxy 'tami5/lspsaga.nvim'

" autopairs for neovim 
Proxy 'windwp/nvim-autopairs'

" statusline
" Proxy 'nvim-lua/lsp-status.nvim' 在我的配置文件中无效
Proxy 'nvim-lualine/lualine.nvim'
Proxy 'arkav/lualine-lsp-progress'

Proxy 'lewis6991/gitsigns.nvim'

Proxy 'nvim-treesitter/nvim-treesitter'
Proxy 'SmiteshP/nvim-gps'

" 右侧阅读进度滚动条
" Proxy 'Xuyuanp/scrollbar.nvim'

Proxy 'liuchengxu/vista.vim'
Proxy 'rust-lang/rust.vim'

" === 用着顺手的老插件 ===
" Proxy 'LunarWatcher/auto-pairs'
Proxy 'tpope/vim-surround'
Proxy 'junegunn/vim-easy-align'

Proxy 'godlygeek/tabular'
Proxy 'plasticboy/vim-markdown'
Proxy 'ap/vim-css-color'
Proxy 'preservim/nerdcommenter'
Proxy 'dhruvasagar/vim-table-mode'
Proxy 'mg979/vim-visual-multi'
Proxy 'rhysd/clever-f.vim'
call plug#end()

