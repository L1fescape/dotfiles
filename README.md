# Env Settings and configs

## Installation

Copies configs into `$HOME`. Run from the repo root:

```bash
bash install.sh              # install everything
bash install.sh zsh tmux     # install specific targets only
bash install.sh help         # list targets
```

### Keymaps

The bindings from `.vimrc` carry over, including `<Space>` as leader, `\` as the
toggle prefix, `L`/`H` for tabs and `<leader>hjkl` for splits. The differences
worth knowing:

| Key | Does |
| --- | --- |
| `<leader>o` | Find files (was ctrlp) |
| `<leader>a`, `<C-f>` | Grep the project (was ag.vim) |
| `<leader>n` | Toggle the file tree (was NERDTree) |
| `<leader>f` | Format the buffer |
| `<C-k>` / `<C-j>` | Grow / shrink the selection by syntax node |
| `gd`, `gr`, `gh` | Go to definition, list references, hover docs |
| `<leader>cr`, `<leader>ca` | Rename symbol, code action |
| `<leader>g…` | Git hunks and status |
| `\u` | Undo history (was gundo) |

Hover is on `gh` rather than the usual `K`, because `K` is already the
join-with-line-above mapping from the vim config.

Icons are off by default since `fonts/` ships Powerline fonts rather than Nerd
Fonts. Install a [Nerd Font](https://www.nerdfonts.com) and set
`vim.g.have_nerd_font = true` in `nvim/lua/config/options.lua` to turn them on.

## Acknowledgements

- [Mathias Bynens](https://github.com/mathiasbynens) ([dotfiles](https://github.com/mathiasbynens/dotfiles))
- [Zach Holman](https://github.com/holman) ([dotfiles](https://github.com/holman/dotfiles))
- [Paul Irish](https://github.com/paulirish) ([dotfiles](https://github.com/paulirish/dotfiles))
- [Mahdi Yusuf](https://github.com/myusuf3) ([dotfiles](https://github.com/myusuf3/dotfiles))
- [Nicolas Gallagher](https://github.com/necolas) ([dotfiles](https://github.com/necolas/dotfiles))
- [Gary Bernhardt](https://github.com/garybernhardt) ([dotfiles](https://github.com/garybernhardt/dotfiles))
- [Sindre Sorhus](https://github.com/sindresorhus)
- [Amir Salihefendic](https://github.com/amix) ([vimrc](https://github.com/amix/vimrc))
