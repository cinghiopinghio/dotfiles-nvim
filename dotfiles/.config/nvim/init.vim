" vimrc file.

"----------------------------------------------------------------------
" PREABLE
let maplocalleader=' '

"-------------------------------------------------------------------------
" SET OPTIONS

source ${HOME}/.config/nvim/config/settings.vim

"-------------------------------------------------------------------------
" MANAGE PLUGINS
lua require('plugins')
" source ${HOME}/.config/nvim/config/plugins.vim
autocmd BufWritePost init.lua PackerCompile

"-------------------------------------------------------------------------
" MAP
source ${HOME}/.config/nvim/config/maps.vim
source ${HOME}/.config/nvim/config/fzf.vim

set termguicolors
lua require('init')

command! Top call simplerun#toggle("top")
nnoremap <F7> :call simplerun#toggle()<CR>
let g:simplerun_commands = {
            \ 'tex': 'latexmk -pvc -pdf -interaction=nonstopmode',
            \ 'lua': 'lua5.2'
            \ }
