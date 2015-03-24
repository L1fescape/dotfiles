set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'bling/vim-airline'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'kien/ctrlp.vim'
Bundle 'sjl/gundo.vim'
Bundle 'mattn/emmet-vim'
Bundle 'rking/ag.vim'

" HTML, CSS, Javascript
Bundle 'jakar/vim-json'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'JulesWang/css.vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'othree/html5.vim'

" Themes
Bundle 'sjl/badwolf'
Bundle 'akenn/itg_flat_vim'

filetype plugin indent on
