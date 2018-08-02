" Vim Expand Region settings
map <C-k> <Plug>(expand_region_expand)
map <C-j> <Plug>(expand_region_shrink)

" mapping for Gundo
noremap \u :GundoToggle<CR>

" Settings for Airline
let g:airline_theme='light'
let g:airline_powerline_fonts=1

" Settings for Vim Gutter
exe 'hi! SignColumn guibg=NONE ctermbg=235'
