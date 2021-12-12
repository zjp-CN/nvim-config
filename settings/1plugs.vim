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

" === 用着顺手的老插件 ===
" Proxy 'LunarWatcher/auto-pairs'
Proxy 'tpope/vim-surround'
Proxy 'junegunn/vim-easy-align'

Proxy 'godlygeek/tabular'
Proxy 'plasticboy/vim-markdown'
Proxy 'ap/vim-css-color'
Proxy 'preservim/nerdcommenter'
call plug#end()

