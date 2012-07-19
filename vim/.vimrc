set nocompatible                    " choose no compatibility with legacy vi
syntax on                           " turn syntax highlighting on
set encoding=utf-8                  " set encoding to utf-8
set showcmd                         " display incomplete commands
filetype plugin indent on           " load file type plugins + indentation

" Tabs and Spaces
set nowrap                          " don't wrap lines
set tabstop=2 shiftwidth=2          " a tab is two spaces
set backspace=indent,eol,start      " backspace through everything in insert mode
set softtabstop=2                   " respect hard tabs
set noexpandtab											" don't convert tabs to spaces

" Numbers
set number                          " Show numbers

" SWAGG
set cursorline                      " Shows the horizontal cursor line
set nowrap                          " 
set anti                            " 
set guifont=Ubuntu\ Mono\ Bold\ 10  " Setting font

" Turn off Swap Files
set noswapfile
set nobackup
set nowb 

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " incremental searching
set ignorecase                      " searches are case insensitive...
set smartcase                       " ... unless they contain at least one capital letter

"" Mappings
nmap <F8> :TagbarToggle<CR>         " mapping f8 to TagbarToggle
nmap <F2> :NERDTreeToggle<CR>       " mapping f2 to NERDTreeToggle
nmap <F3> :NumbersToggle<CR>        " mapping f3 to NumbersToggle
noremap <F5> :GundoToggle<CR>       " mapping f5 to Gundo

"" Color Scheme
colorscheme tomorrow_night          " Tomorrow Theme

set laststatus=2                    " Always show the statusline

" Enable fancy mode 
let g:Powerline_symbols = 'fancy'   " Powerline

" Call Pathogen
call pathogen#infect()
