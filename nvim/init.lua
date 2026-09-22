-- Neovim entry point.
--
--   lua/config/   editor settings, keymaps, autocommands
--   lua/plugins/  one file per plugin group, collected by lazy.nvim
--   lua/util/     small helpers that aren't worth a plugin
--
-- The vim config in ~/.vimrc is kept separate and untouched, so `vim` still
-- works the way it always has.

if vim.fn.has("nvim-0.11") == 0 then
  vim.api.nvim_echo({
    { "This config needs Neovim 0.11+. Run `bash install.sh nvim-install`.\n", "ErrorMsg" },
  }, true, {})
  return
end

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
