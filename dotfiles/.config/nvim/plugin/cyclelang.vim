" cycle through a number of languages
let g:local_dictionaries = {
            \ 'it': ['/usr/share/dict/italian'],
            \ 'en_gb': ['/usr/share/dict/british-english'],
            \ 'fr': ['/usr/share/dict/french'],
            \ 'es': ['/share/dict/spanish'],
            \ }

function! CycleLang()
    let langs = ['en_gb', 'it', 'fr', 'es', '']
    set dictionary=/usr/share/dict/words
    let i = index(langs, &spelllang)
    let j = (i+1)%len(langs)
    let &spelllang = langs[j]

    if empty(&spelllang)
        set nospell
        echo 'Unset spell language'
    else
        set spell
        echo 'Using: "'.&spelllang.'" spell language'
    endif
endfunction
nnoremap <F6> :call CycleLang()<CR>
