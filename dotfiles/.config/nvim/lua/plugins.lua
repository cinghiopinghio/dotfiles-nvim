vim.cmd 'packadd paq-nvim'         -- Load package
package.loaded['paq-nvim'] = nil   -- Refresh package list
local Pq = require('paq-nvim')
local paq = Pq.paq  -- Import module and bind `paq` function

paq{'savq/paq-nvim', opt=true}     -- Let Paq manage itself

-- comment uncomment with gcc
paq 'tpope/vim-commentary'
-- increase/decrease dates with c-a c-x
paq 'tpope/vim-speeddating'

-- Linter and grammar

-- paq 'rhysd/vim-grammarous'
-- paq 'vigoux/LanguageTool.nvim'
-- let g:languagetool_server_jar='/usr/share/java/languagetool/languagetool-server.jar'
-- paq 'reedes/vim-wordy'
paq 'davidbeckingsale/writegood.vim'

-- Completion
paq 'neovim/nvim-lspconfig'
paq 'hrsh7th/nvim-compe'

paq {'nvim-treesitter/nvim-treesitter', run=vim.cmd 'TSUpdate'}   -- We recommend updating the parsers on update
paq 'romgrk/nvim-treesitter-context'
paq 'nvim-treesitter/nvim-treesitter-refactor'
paq 'nvim-treesitter/playground'

paq 'ojroques/nvim-lspfuzzy'

-- Snippets
paq 'SirVer/ultisnips'
-- Snippets are separated from the engine. Add this if you want them:
paq 'honza/vim-snippets'
--  complete parenthesis
paq 'jiangmiao/auto-pairs'

--  word editing (ctrl-A)
paq 'bootleq/vim-cycle'

paq 'liuchengxu/vista.vim'

paq 'voldikss/vim-floaterm'

-- keep folds as is until save of fold/unfold (save time)
paq 'Konfekt/FastFold'
-- plugin to remove search highlight once the cursor moved
paq 'romainl/vim-cool'
-- find and replace with s {substitute, search}
paq 'hauleth/sad.vim'
-- highlight coursos on jumps
paq 'DanilaMihailov/beacon.nvim'
-- A vim plugin to display the indention levels with thin vertical lines
paq {'lukas-reineke/indent-blankline.nvim', branch='lua' }

paq {'junegunn/fzf', run='./install --all' }
paq 'junegunn/fzf.vim'
-- This is the default extra key bindings
-- nmap <localleader>ft :call LanguageClient_textDocument_documentSymbol()<CR>
-- use the neomru cache!
paq 'Shougo/neomru.vim'

--}}}

-- Align blocks
paq 'tommcdo/vim-lion'

-- switch position of arguments
paq 'AndrewRadev/sideways.vim'

-- A plugin to expand args brtween parenthesis
paq 'FooSoft/vim-argwrap'

paq 'lifepillar/vim-colortemplate'
paq 'andreypopp/vim-colors-plain'
paq 'pgdouyon/vim-yin-yang'
paq 'axvr/photon.vim'
paq 'freeo/vim-kalisi'
paq 'tomasr/molokai'

paq 'datwaft/bubbly.nvim'

paq 'AndrewRadev/linediff.vim'

paq 'airblade/vim-rooter'

paq 'cespare/vim-toml'
paq 'freitass/todo.txt-vim'
paq 'lervag/vimtex'
paq 'othree/html5.vim'
paq 'pangloss/vim-javascript'

paq 'norcalli/nvim-colorizer.lua'

paq 'goerz/jupytext.vim'

paq {'iamcco/markdown-preview.nvim', run='cd app & yarn install'}
paq 'ferrine/md-img-paste.vim'

Pq.install()
Pq.update()
Pq.clean()
