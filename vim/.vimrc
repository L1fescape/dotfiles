" Tabs and Spaces
set nowrap                          " don't wrap lines
set tabstop=2 shiftwidth=2          " a tab is two spaces
set backspace=indent,eol,start      " backspace through everything in insert mode
set softtabstop=2                   " respect hard tabs
set expandtab                       " convert tabs to spaces


" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1


" Turn off Swap Files
set noswapfile
set nobackup
set nowb 

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " incremental searching
set ignorecase                      " searches are case insensitive ...
set smartcase                       " ... unless they contain at least one capital letter


"" Mappings
nmap <F8> :TagbarToggle<CR>         " mapping f8 to TagbarToggle
nmap <F2> :NERDTreeToggle<CR>       " mapping f2 to NERDTreeToggle
nmap <F3> :NumbersToggle<CR>        " mapping f3 to NumbersToggle
noremap <F5> :GundoToggle<CR>       " mapping f5 to Gundo
set pastetoggle=<F1>


" Splits
"" switching splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"" resizing splits
map = <c-w>+
map - <c-w>-
map + <c-w><
map _ <c-w>>
"" new splits
map <Bar> <c-w>v
map \ <c-w>n
"" open new splits to right and bottom
set splitbelow
set splitright


" Swag 
colorscheme jellybeans
set term=screen-256color
set cursorline                      " Shows the horizontal cursor line
set nowrap                          " Don't wrap long lines
set anti                            " 
set guifont=Ubuntu\ Mono\ Bold\ 10  " Setting font
set number                          " Show line numbers
set mouse=a                         " Enable mouse
set laststatus=2                    " Always show the statusline
set nocompatible                    " choose no compatibility with legacy vi
syntax on                           " turn syntax highlighting on
set encoding=utf-8                  " set encoding to utf-8
set showcmd                         " display incomplete commands
filetype plugin indent on           " load file type plugins + indentation


"" Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set t_Co=256
let g:Powerline_symbols = 'unicode'

" Call Pathogen
call pathogen#infect()
