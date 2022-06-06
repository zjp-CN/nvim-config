" vim-plug 安装的插件

" function Proxy(str)
" let prefix = 'https://github.com.cnpmjs.org/'
"   Plug  prefix . a:str . '.git'
" endfunction
"
" command! -nargs=1 Proxy :call Proxy(<args>)

call plug#begin(expand(stdpath('config')) . '/plugged')
" === https://sharksforarms.dev/posts/neovim-rust/ ===
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'
" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'
Plug 'Canop/nvim-bacon'

" Fuzzy finder
" Optional
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Plug 'glepnir/lspsaga.nvim'
Plug 'tami5/lspsaga.nvim'

" autopairs for neovim 
Plug 'windwp/nvim-autopairs'

" statusline
" Plug 'nvim-lua/lsp-status.nvim' 在我的配置文件中无效
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'

Plug 'lewis6991/gitsigns.nvim'

Plug 'ldelossa/litee.nvim'
Plug 'ldelossa/litee-calltree.nvim'
Plug 'ldelossa/litee-symboltree.nvim'
" Plug 'file:///rust/github/litee-symboltree.nvim'
Plug 'ldelossa/litee-filetree.nvim'
" Plug 'file:///rust/github/litee-filetree.nvim'
" Plug 'ldelossa/litee-bookmarks.nvim'

" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'SmiteshP/nvim-gps'

" 右侧阅读进度滚动条
" Plug 'Xuyuanp/scrollbar.nvim'

Plug 'liuchengxu/vista.vim'
Plug 'rust-lang/rust.vim'

Plug 'saecki/crates.nvim'

" debug
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" 折叠
" neovim 暂时没支持 folding: https://github.com/neovim/neovim/pull/14306
" vim-lsp 是支持的： https://github.com/prabirshrestha/vim-lsp/blob/master/autoload/lsp/ui/vim/folding.vim
" 暂时的解决方法： https://github.com/pierreglaser/folding-nvim
" 但是有点问题： https://github.com/pierreglaser/folding-nvim/issues/5
" 暂时用未合并的分支
" Plug 'Nicholas-Hein/folding-nvim'
" Plug 'Nicholas-Hein/folding-nvim'
" Plug 'pierreglaser/folding-nvim'

" === 用着顺手的老插件 ===
" Plug 'LunarWatcher/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ap/vim-css-color'
Plug 'preservim/nerdcommenter'
Plug 'dhruvasagar/vim-table-mode'
Plug 'mg979/vim-visual-multi'
Plug 'rhysd/clever-f.vim'
Plug 'azabiong/vim-highlighter'

" Plug '/rust/tmp/neovim-calculator'
call plug#end()

