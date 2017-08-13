" NerdTree
nmap <leader>n :NERDTreeTabsToggle<CR>
"" Close NERDTree if it's the only remaining window
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
  "                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction

"" NERDTree autocommands
autocmd WinEnter * call NERDTreeQuit()
" autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | wincmd p | endif " give current file focus instead of NERDTree
"" NERDTree settings
let nerdtree_tabs_open_on_console_startup=0 " don't open NERDTree on startup
