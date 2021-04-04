set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

function! Docgen_py()
    execute "!pyment --output numpydoc --init2class --write %"
endfunction


command! Docgen call Docgen_py()
