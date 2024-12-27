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
set vb t_vb= "disable visual bell + terminal bell

" Status strings
set laststatus=2 "always show the status line
set statusline=%f\ %m%r%h%w\ [%l,%v]\ [%L]\ (%p%%)
set titlestring=%{ObsessionStatus()}\ %{getcwd()}

" File tabbing
autocmd FileType json,sh setlocal expandtab
autocmd FileType json,sh setlocal shiftwidth=4
autocmd FileType json,sh setlocal tabstop=4
autocmd FileType json,sh setlocal softtabstop=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set tabstop=4
au BufRead,BufNewFile *.py,*.pyw set softtabstop=4
au BufRead,BufNewFile *.js,*.ts,*.tsx set expandtab
au BufRead,BufNewFile *.js,*.ts,*.tsx set shiftwidth=2
au BufRead,BufNewFile *.js,*.ts,*.tsx set tabstop=2
au BufRead,BufNewFile *.js,*.ts,*.tsx set softtabstop=2
au BufRead,BufNewFile *.html,*.php,*.css,*.rb,*.ejs set expandtab
au BufRead,BufNewFile *.html,*.php,*.css,*.rb,*.ejs set shiftwidth=2
au BufRead,BufNewFile *.html,*.php,*.css,*.rb,*.ejs set tabstop=2
au BufRead,BufNewFile *.html,*.php,*.css,*.rb,*.ejs set softtabstop=2
au BufRead,BufNewFile *.haml,*.sass,*.scss,*.yml,*.yaml set expandtab
au BufRead,BufNewFile *.haml,*.sass,*.scss,*.yml,*.yaml set shiftwidth=2
au BufRead,BufNewFile *.haml,*.sass,*.scss,*.yml,*.yaml set tabstop=2
au BufRead,BufNewFile *.haml,*.sass,*.scss,*.yml,*.yaml set softtabstop=2

" FileType maps
" php + ejs as html
au BufRead,BufNewFile *.php,*.ejs set filetype=html
" har as json
au BufRead,BufNewFile *.har set filetype=json

" Some specific behaviours for certain FileTypes
au FileType markdown,text setlocal textwidth=78 "text file line length of 78 chars
autocmd FileType gitcommit,markdown set spell "turn on spellcheck

" Markdown Preview
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 0
let g:mkdp_combine_preview = 1

" Key mappings
let mapleader=" "
map <F3> :nohl <CR>
map <F4> :set spell!<CR>
map <C-g> :FufFileWithCurrentBufferDir <CR>
nmap <leader>t :Texplore .<CR>
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
" map - <C-W><

"autoindent line
nnoremap <leader>= ==
nnoremap <leader>a ==
vnoremap <leader>a ==
nmap <leader>p p<leader>a
nmap <leader>P P<leader>a

"search and replace highlighted text
vnoremap <silent> <leader>s :call VisualSelection('f')<CR>n
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

"return to last edit position when opening a file
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
set viminfo^=%

" Vinegar
let &wildignore = '*.swo,*.swp,*.pyc'

" Static code checkers
"" Bash (not all are supported by ALE)
" bashate: install with pip
" shellcheck: install with homebrew or apt-get
" sh: install as system package
"" JSON
" jsonlint: install with npm
"" JavaScript
" jshint: install with npm
" jscs: install with npm
"" Python
" pylint: install with pip
" mypy: install with pip
"" Typescript
" tslint: install with npm (also install typescript)

" ALE
let g:ale_lint_delay = 50
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = "normal"
let g:ale_list_window_size = 5
let g:ale_open_list = 1
let g:ale_python_mypy_options = "--fast-parser --python-version 3.6"
let g:ale_python_pylint_change_directory = 0

" Airline
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" NERD Commenter
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

" SimpylFold
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0
let b:SimpylFold_fold_docstring = 0

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
Plugin 'gmarik/vundle'

"github
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'jnurmine/Zenburn'
Plugin 'cespare/vim-toml'
Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'groenewege/vim-less'
Plugin 'hdima/python-syntax'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
"css highlighting inside JS/TS strings/objects
Plugin 'styled-components/vim-styled-components'
Plugin 'maralla/vim-toml-enhance' "depends on cespare/vim-toml
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/nerdcommenter'
Plugin 'taku-o/vim-reorder-columns'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/matchit.zip'
Plugin 'w0rp/ale'

"vim-scripts
Plugin 'L9'
Plugin 'FuzzyFinder'

filetype plugin indent on "turn on filetype options: detection, plugin, indent
syntax on "syntax highlighting

" color scheme
if has('gui_running')
	set background=dark
	colorscheme solarized
else
	set t_Co=256
	let g:solarized_termcolors=256
	set background=dark
	colorscheme solarized
endif
call togglebg#map("")

" Code folding
set foldlevelstart=1
au FileType javascript call JavaScriptFold()
au FileType json set foldmethod=indent
let g:is_bash=1
let g:sh_fold_enabled=3
