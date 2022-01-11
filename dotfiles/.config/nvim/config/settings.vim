" ==========================================
" NeoVim Defalults
" set nocompatible
" syntax on
" filetype plugin indent on
" set hlsearch
" set incsearch
" set background=dark
" set encoding=utf-8
" set autoindent
" ==========================================

"" INDENT
set complete+=k         " enable dictionary completion
set dictionary+=/usr/share/dict/words

set completeopt=menuone,noselect
set cmdheight=2

set tabstop=4
set smartindent   " do smart autoindenting
set shiftwidth=4  " Number of spaces to use for each step of (auto)indent.
set softtabstop=4 " Number of spaces that a <Tab> counts for
set expandtab     " Use the appropriate number of spaces to insert a <Tab>.
set smarttab      " a <Tab> in front of a line inserts blanks according to 'shiftwidth'.

set formatoptions=tcrqnl1j
" auto format
" t text
" c comments
" r auto comment new line
" q auto format comments with gq
" n respect lists
" l long lines are not broken
" 1 break before one-char words
" j remove comment leader when joining

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=100                " keep 100 lines of command line history
set noruler                    " statusline already has it
set noshowcmd                  " display incomplete commands (slow)

set isfname+={,}           " some filenames iclude parenthesis (useful for `gf`)
set clipboard+=unnamedplus " yank and copy to clipboard

set title                  " set terminal title

set updatetime=250

" SEARCH
set ignorecase " case-insensitive search
set smartcase  " upper-case sensitive search

if has('nvim')
    set inccommand=split " show command output as-you-type
endif

set winwidth=80
set winminwidth=20

set colorcolumn=80
set cursorline
set number
set norelativenumber
set signcolumn=number

" set showtabline=1
au OptionSet showtabline :set showtabline=1

set scrolloff=10  " never reach the top or bottom of the page

"wrapping
set wrap
" set wrapmargin=20 " wrap from wrapmargin columns from right (insert <EOL>)
set linebreak " Vim will wrap long lines at a character in 'breakat' rather
set showbreak=↳\
set breakindent

set splitbelow " new split below current
set splitright " new vsplit right of current

set list " show tabs and trailing whitespaces
set listchars=tab:╟─,trail:┄,extends:┄
set fillchars+=vert:┃

" diff
set diffopt=internal,filler,closeoff,hiddenoff,algorithm:patience

iabbrev mf Mauro Faccin
iabbrev ... …
iabbrev piu più
iabbrev perche perché

if has('termguicolors')
    set termguicolors " enable 24bit colors for the terminal
endif

" use this script to know the background
if !empty(glob("~/.local/bin/day2night"))
    exec 'set background=' . system("~/.local/bin/day2night")
endif

if has('conceal')
    set conceallevel=2
    set concealcursor=""   " do not conceal on my line
    let g:tex_conceal="abdmgs"
    "   a = accents/ligatures
    "   b = bold and italic
    "   d = delimiters
    "   m = math symbols
    "   g = Greek
    "   s = superscripts/subscripts
endif
let g:tex_flavor = 'latex'

let s:host=substitute(hostname(), "\\..*", '', '')
if s:host == 'dingo'
    let g:futon_transp_bg=1
    colorscheme futon
elseif s:host == 'spin'
    colorscheme seoul256
else
    colorscheme molokai
endif
"}}}

set makeprg=make
set grepprg=grep\ -nH\ $*
set showmode

" Wildmenu
if has("wildmenu")
    set wildignore+=*.a,*.o
    " set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
    set wildmenu
    set wildmode=longest,full
endif
if has('nvim')
    set wildoptions=pum
    set pumblend=20
    set winblend=20
endif

set ls=2  " show statusline always
set dir=/tmp//,/var/tmp//,.
set mouse=a

" do not search for the binary
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:python3_host_prog = '/usr/bin/python3'

autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            \ |   exe "normal! g`\""
            \ | endif

" use 0 to toggle position between 0 and ^
function HomeToggle()
    if col('.') == 1
        normal! ^
    else
        normal! 0
    endif
endfunction
vnoremap 0 :call HomeToggle()<cr>
nnoremap 0 :call HomeToggle()<cr>

" autoremove trailing white spaces
function <sid>StripTrailingSpaces()
    if !&binary && &filetype != 'diff'
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endif
endfunction
autocmd BufWritePre * :call <sid>StripTrailingSpaces()

autocmd BufWritePost * normal zx

" augroup folds
"   " Don't screw up folds when inserting text that might affect them, until
"   " leaving insert mode. Foldmethod is local to the window. Protect against
"   " screwing up folding when switching between windows.
"   autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"   autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
" augroup END
set foldmethod=indent

function TabSize(size)
    execute 'setlocal tabstop=' . a:size
    execute 'setlocal shiftwidth=' . a:size
    execute 'setlocal softtabstop=' . a:size
    setlocal expandtab
endfunction

command! -nargs=1 Tabsize call TabSize( <args> )

function! CustomFoldText(string) "{{{1
    "get first non-blank line
    let line = repeat('❱', v:foldlevel) . strcharpart(getline(v:foldstart), v:foldlevel)
    let fs = v:foldstart + 1
    while fs <= v:foldend && len(line) < 80
        let line = line . " " . trim(getline(fs), '\s ', 1)
        let fs = nextnonblank(fs + 1)
    endwhile
    let line = substitute(line, '\t', repeat(' ', &tabstop), 'g')

    let w = get(g:, 'custom_foldtext_max_width', winwidth(0)) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = '+'. v:folddashes
    let lineCount = line("$")
    if has("float")
        try
            let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
        catch /^Vim\%((\a\+)\)\=:E806/	" E806: Using Float as String
            let foldPercentage = printf("[of %d lines] ", lineCount)
        endtry
    endif
    if exists("*strwdith")
        let expansionString = repeat(a:string, w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    else
        let expansionString = repeat(a:string, w - strlen(substitute(foldSizeStr.line.foldLevelStr.foldPercentage, '.', 'x', 'g')))
    endif
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

" set foldtext=CustomFoldText('.')
