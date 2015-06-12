set nocompatible  "required for a bunch of cool vim stuff
                  "should be at the top of the file
filetype on "turn on before off so vim doesn't error
filetype off "required for Vundle; reset properly at the bottom

set autoread "auto reload a file when edited externally
set backspace=indent,eol,start "make backspace work as expected
set guitablabel=(%N%M)\ %f "tab label format
set history=50 "command history
set hlsearch "highlight search matches
set incsearch "jump to search match while typing
set nobackup "disable ~backup files
set number "show line numbers
set ruler "show line + column number and % progress through file in status line
set showcmd "show commands as they're typed
set showmatch "highlight matching braces
set spelllang=en_ca "set spelling language to Canadian English
set statusline=%F\ %m%r%h%w\ [%l,%v]\ [%L]\ (%p%%) "status line format
set vb t_vb= "disable visual bell + terminal bell

" File tabbing
au BufRead,BufNewFile *.py,*.pyw,*.sh,*.js set expandtab
au BufRead,BufNewFile *.py,*.pyw,*.sh,*.js set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.sh,*.js set tabstop=4
au BufRead,BufNewFile *.py,*.pyw,*.sh,*.js set softtabstop=4
au BufRead,BufNewFile *.html,*.php,*.css,*.rb,*.ejs set shiftwidth=2
au BufRead,BufNewFile *.html,*.php,*.css,*.rb,*.ejs set expandtab
au BufRead,BufNewFile *.html,*.php,*.css,*.rb,*.ejs set tabstop=2
au BufRead,BufNewFile *.html,*.php,*.css,*.rb,*.ejs set softtabstop=2
au BufRead,BufNewFile *.haml,*.sass,*.scss,*.yml,*.yaml set shiftwidth=2
au BufRead,BufNewFile *.haml,*.sass,*.scss,*.yml,*.yaml set expandtab
au BufRead,BufNewFile *.haml,*.sass,*.scss,*.yml,*.yaml set tabstop=2
au BufRead,BufNewFile *.haml,*.sass,*.scss,*.yml,*.yaml set softtabstop=2

au BufRead,BufNewFile *.php,*.ejs set filetype=html "treat php + ejs as html
au FileType text setlocal textwidth=78 "text file line length of 78 chars

" Key mappings
let mapleader=" "
map <F2> :NERDTreeToggle <CR>
map <F3> :nohl <CR>
map <F4> :set spell!<CR>
map <C-g> :FufFileWithCurrentBufferDir <CR>
nmap <leader>t :tabnew<CR>:NERDTreeToggle<CR>
nmap [e :lprevious<CR>
nmap ]e :lnext<CR>

" diff mode specific config
if &diff
    nmap :Q :qa
endif

"alt-{#} to change tabs
nmap <M-1> 1gt
nmap <M-2> 2gt
nmap <M-3> 3gt
nmap <M-4> 4gt
nmap <M-5> 5gt
"command-{#} to change tabs
nmap <D-1> 1gt
nmap <D-2> 2gt
nmap <D-3> 3gt
nmap <D-4> 4gt
nmap <D-5> 5gt

"use arrow keys to change buffers
map <up> <C-W>k
map <down> <C-W>j
map <left> <C-W>h
map <right> <C-W>l

"change buffer size
map + <C-W>+
map _ <C-W>-
map = <C-W>>
map - <C-W><

"autoindent line
nnoremap <leader>= ==
nnoremap <leader>a ==
vnoremap <leader>a ==
nmap <leader>p p<leader>a
nmap <leader>P P<leader>a

"search and replace highlighted text
vnoremap <silent> <leader>s :call VisualSelection('f')<CR>n
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

"auto open NERDTree if no file specified
autocmd vimenter * if !argc() | NERDTree | endif

"return to last edit position when opening a file
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
set viminfo^=%

" Python - hightlight line cols 79 and beyond
hi Col79	guibg=#61380b
hi Col80	guibg=#610b0b
au BufWinEnter *.py let w:m1=matchadd('Col79', '\%<81v.\%>80v', -1)
au BufWinEnter *.py let w:m2=matchadd('Col80', '\%>80v.\+', -1)

"NERDTree options
let NERDTreeIgnore = ['\.pyc$']

"Syntastic options
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height=5
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'active',
			   \ 'active_filetypes': ['javascript', 'python'],
			   \ 'passive_filetypes': ['html'] }
let g:syntastic_javascript_checkers=['jshint', 'jscs']
let g:syntastic_python_checkers=['pylint']
"let g:syntastic_python_pylint_args="--rcfile=$HOME/.pylintrc"

" Functions
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Vundle
" help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"let Vundle manage Vundle
Bundle 'gmarik/vundle'

"github
Bundle 'airblade/vim-gitgutter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'groenewege/vim-less'
Bundle 'hdima/python-syntax'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'rodjek/vim-puppet'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/matchit.zip'

"vim-scripts
Bundle 'L9'
Bundle 'FuzzyFinder'

filetype plugin indent on "turn on filetype options: detection, plugin, indent
syntax on "syntax highlighting

" color scheme
if has('gui_running')
	set background=light
else
	set background=dark
endif
colorscheme solarized
call togglebg#map("")

" Code folding
set foldlevelstart=1
au FileType javascript call JavaScriptFold()
let g:is_bash=1
let g:sh_fold_enabled=3
