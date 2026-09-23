# Neovim

`nvim/` is a Lua config built on [lazy.nvim](https://github.com/folke/lazy.nvim).
It is independent of `vim/`, so `vim` keeps working exactly as it always has.

```bash
# from the root dir
bash install.sh nvim-install # download neovim + tree-sitter into ~/.local
bash install.sh nvim         # copy the config into ~/.config/nvim
```

`nvim-install` is not part of the default run because it downloads binaries
rather than copying configs. Skip it if neovim came from your package manager,
as long as it is 0.11 or newer.

Language servers install themselves on the first interactive launch; watch
progress with `:Mason`. Servers that need a toolchain already on the machine
(`gopls`, `pyright`) are left out of that list — add them from `:Mason` when the
toolchain is there.

The `.aliases` file points `vi`, `v`, `vim` and `diff` at neovim when it is
installed and falls back to vim when it isn't, so the same dotfiles work on
machines without it.

## Layout

| Path | Contents |
| --- | --- |
| `nvim/init.lua` | Entry point |
| `nvim/lua/config/` | Options, keymaps, autocommands, lazy.nvim bootstrap |
| `nvim/lua/plugins/` | One file per plugin group |
| `nvim/lua/util/` | Helpers too small to be plugins |

## Keymaps

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
