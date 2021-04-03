set foldmethod=indent

function! Docgen_py()
    execute "!pyment --output numpydoc --init2class --write %"
endfunction


command! Docgen call Docgen_py()
