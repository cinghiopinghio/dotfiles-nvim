" let g:fzf_action = {
"             \ 'ctrl-t': 'tab split',
"             \ 'ctrl-x': 'split',
"             \ 'ctrl-v': 'vsplit'
"             \ }
" let g:fzf_colors = {
"             \ 'fg':      ['fg', 'Normal'],
"             \ 'bg':      ['bg', 'Pmenu'],
"             \ 'hl':      ['fg', 'Warning'],
"             \ 'fg+':     ['fg', 'PmenuSel', 'CursorColumn', 'Normal'],
"             \ 'bg+':     ['bg', 'PmenuSel', 'CursorColumn'],
"             \ 'hl+':     ['fg', 'Error'],
"             \ 'info':    ['fg', 'PreProc'],
"             \ 'border':  ['fg', 'Pmenu'],
"             \ 'prompt':  ['fg', 'Conditional'],
"             \ 'pointer': ['fg', 'Exception'],
"             \ 'marker':  ['fg', 'Keyword'],
"             \ 'spinner': ['fg', 'Label'],
"             \ 'header':  ['fg', 'PmenuSel']
"             \ }

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" " get most recent files with preview
" command! -bang Files
"             \ call fzf#run(fzf#wrap({
"             \ 'options': ['--tiebreak=index', '--preview', 'bat --color=always --plain {}'],
"             \ 'source': 'find . -type d -name .ipynb_checkpoints -prune -o -type d -name __pycache__ -prune -o -type d -name .git -prune -o -type f -o -type l'
"             \ }, <bang>0))
" nmap <localleader>ff :Files<CR>
" nmap <localleader>fb :Buffers<cr>
" nmap <localleader>fg :GitFiles<cr>
" command! -bang History
"             \ call fzf#run(fzf#wrap({
"             \ 'options': ['--tiebreak=index', '--preview', 'bat --color=always --plain {}'],
"             \ 'source': 'cat ~/.cache/neomru/file | sed 1d'
"             \ }, <bang>0))
" nmap <localleader>fr :History<cr>
" nmap <localleader>fl :Lines<cr>

au FileType fzf silent! tunmap <Esc>

nmap <localleader>ff :FzfLua files<CR>
nmap <localleader>fb :FzfLua buffers<cr>
nmap <localleader>fg :FzfLua git_files<cr>
nmap <localleader>fr :FzfLua oldfiles<cr>
nmap <localleader>fl :FzfLua lines<cr>
