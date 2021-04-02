" vimrc file.

"----------------------------------------------------------------------
" PREABLE
let maplocalleader=' '
filetype indent plugin on
syntax on

"----------------------------------------------------------------------
" Plugin Manager
" source ${HOME}/.config/nvim/config/plugins.vim

"-------------------------------------------------------------------------
" SET OPTIONS
source ${HOME}/.config/nvim/config/settings.vim

"-------------------------------------------------------------------------
" MAP
source ${HOME}/.config/nvim/config/maps.vim

source ${HOME}/.config/nvim/config/fzf.vim

set termguicolors
lua require('init')

command! Top call simplerun#toggle("top")
nnoremap <F7> :call simplerun#toggle()<CR>

command! PlugUp lua require 'plugins'
