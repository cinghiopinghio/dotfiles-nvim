setlocal shiftwidth=2 softtabstop=2 expandtab smarttab
set wrap linebreak nolist textwidth=0 wrapmargin=0

imap <C-p> <C-O>gqip

inoremap <expr> <c-x><c-a> fzf#vim#complete(fzf#wrap({
            \ 'source': 'bibtex-ls *.bib',
            \ 'options': '--multi --reverse --ansi --prompt "cite> " --preview "echo {} \| bibtex-markdown *.bib \| sed -e \"s/\([,&\*\s]\)\s\+/\1\n/g\""',
            \ 'reducer': { lines -> system("bibtex-cite -prefix='' -postfix='' -separator=', ' ", lines) }},
            \ ))

"{{{ auto-pairs
let b:AutoPairs={'(':')','[':']','{':'}',"'":"'",'"':'"','$':'$'}
"}}}

"{{{ VIMTEX

let g:vimtex_view_method='zathura'
if has('nvim')
        let g:vimtex_compiler_progname='nvr'
endif

let g:vimtex_fold_enabled=1
let g:vimtex_fold_manual=0
let g:vimtex_view_forward_search_on_start = 1

" nnoremap <localleader>lv :call system("zathura " . expand("%:r") . ".pdf &")<cr>

" cleanup on quit
augroup texmk
        au!
        if exists("*vimtex#compiler#clean")
            au User VimtexEventQuit call vimtex#compiler#clean(0)
        else
            au VimLeave *.tex execute "!latexmk -c"
        endif
augroup END

if exists("*vimtex#complete#omnifunc")
    set omnifunc=vimtex#complete#omnifunc
endif

let g:vimtex_quickfix_mode=2
let g:vimtex_complete_enabled = 1
let g:vimtex_quickfix_ignore_filters = [
      \ 'Marginpar on page',
      \ 'A float is stuck',
      \ 'Underfull',
      \ 'Overfull',
      \]
let g:vimtex_complete_bib = {
                        \ 'abbr_fmt' : '@author_all (@year)',
                        \ 'menu_fmt' : '@title',
                        \}

let g:vimtex_compiler_latexmk = {
        \ 'options' : [
        \   '-shell-escape' ,
        \   '-file-line-error',
        \   '-synctex=1' ,
        \   '-interaction=nonstopmode' ,
        \ ],
        \}

let g:vimtex_compiler_latexmk_engines = { '_': '-pdf' }
