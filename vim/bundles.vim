set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'jakar/vim-json'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'mattn/emmet-vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'pangloss/vim-javascript'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'JulesWang/css.vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'othree/html5.vim'
Bundle 'rking/ag.vim'

" Themes
Bundle 'sjl/badwolf'
Bundle 'cdmedia/itg_flat_vim'

filetype plugin indent on
