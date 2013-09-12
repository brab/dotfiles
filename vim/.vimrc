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

colorscheme wombat

" File tabbing
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set tabstop=4
au BufRead,BufNewFile *.py,*.pyw set softtabstop=4
au BufRead,BufNewFile *.html,*.php,*.js,*.css,*.rb,*.ejs set shiftwidth=2
au BufRead,BufNewFile *.html,*.php,*.js,*.css,*.rb,*.ejs set expandtab
au BufRead,BufNewFile *.html,*.php,*.js,*.css,*.rb,*.ejs set tabstop=2
au BufRead,BufNewFile *.html,*.php,*.js,*.css,*.rb,*.ejs set softtabstop=2
au BufRead,BufNewFile *.haml,*.sass,*.scss set shiftwidth=2
au BufRead,BufNewFile *.haml,*.sass,*.scss set expandtab
au BufRead,BufNewFile *.haml,*.sass,*.scss set tabstop=2
au BufRead,BufNewFile *.haml,*.sass,*.scss set softtabstop=2

au BufRead,BufNewFile *.php,*.ejs set filetype=html "treat php + ejs as html
au FileType text setlocal textwidth=78 "text file line length of 78 chars

" Key mappings
let mapleader=","
map <F2> :NERDTreeToggle <CR>
map <F3> :nohl <CR>
map <F4> :set spell!<CR>
map <C-g> :FufFileWithCurrentBufferDir <CR>
nmap <leader>t :tabnew <CR>

"command-{#} to change tabs
nmap <D-1> 1gt
nmap <D-2> 2gt
nmap <D-3> 3gt
nmap <D-4> 4gt

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

"search and replace highlighted text
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

"Syntastic options
let g:syntastic_mode_map = { 'mode': 'active',
			   \ 'active_filetypes': ['javascript'],
			   \ 'passive_filetypes': ['html', 'python'] }
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_python_checkers=['pylint']

" Functions
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
Bundle 'godlygeek/tabular'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-ragtag'

"vim-scripts
Bundle 'L9'
Bundle 'FuzzyFinder'

filetype plugin indent on "turn on filetype options: detection, plugin, indent
syntax on "syntax highlighting
