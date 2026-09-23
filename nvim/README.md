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
