-- Keymaps, ported from ~/.vimrc. Plugin-specific maps live with their spec in
-- lua/plugins/, so this file only covers built-in behaviour.

local map = vim.keymap.set

-- Saving and quitting -------------------------------------------------------

vim.api.nvim_create_user_command("W", "write", {})
vim.api.nvim_create_user_command("Q", "quit", {})

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>s", "<cmd>mksession<cr>", { desc = "Save session (restore with nvim -S)" })
map("n", "<C-e>", "<cmd>edit<cr>", { desc = "Reload file from disk" })

-- Write a file you opened without the permissions to save it.
map("c", "sudow", "w !sudo tee % >/dev/null", { desc = "Write as root" })

map("n", "<leader>r", "<cmd>source $MYVIMRC<cr>", { desc = "Re-source init.lua" })

-- Movement ------------------------------------------------------------------

-- Step through wrapped lines by screen line rather than buffer line.
map({ "n", "x" }, "j", "gj", { desc = "Down (by screen line)" })
map({ "n", "x" }, "k", "gk", { desc = "Up (by screen line)" })

map("n", "K", "kJ", { desc = "Join with the line above" })
map("n", "B", "^", { desc = "Start of line" })
map("n", "E", "$", { desc = "End of line" })
map("n", "gV", "`[v`]", { desc = "Select last inserted text" })

-- Clear search highlighting. See autocmds.lua for the quickfix exception.
map("n", "<CR>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Tabs ----------------------------------------------------------------------

map("n", "L", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "H", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<leader>t", "<cmd>tabnew<cr>", { desc = "New tab" })

-- Splits --------------------------------------------------------------------

map("n", "<leader>h", "<C-w>h", { desc = "Go to left split" })
map("n", "<leader>j", "<C-w>j", { desc = "Go to split below" })
map("n", "<leader>k", "<C-w>k", { desc = "Go to split above" })
map("n", "<leader>l", "<C-w>l", { desc = "Go to right split" })

map("n", "<leader><Bar>", "<C-w>v", { desc = "Split vertically" })
map("n", "<leader>\\", "<C-w>s", { desc = "Split horizontally" })

map("n", "=", "10<C-w><", { desc = "Narrow split" })
map("n", "-", "10<C-w>>", { desc = "Widen split" })
map("n", "+", "10<C-w>+", { desc = "Grow split" })
map("n", "_", "10<C-w>-", { desc = "Shrink split" })

-- Grow and shrink the selection by syntax node, replacing vim-expand-region.
map({ "n", "x" }, "<C-k>", function()
  require("util.selection").expand()
end, { desc = "Expand selection" })
map("x", "<C-j>", function()
  require("util.selection").shrink()
end, { desc = "Shrink selection" })

-- Diagnostics ---------------------------------------------------------------

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>D", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Toggles (the \ prefix, as in the vim config) -------------------------------

map("n", "\\s", "<cmd>setlocal spell! spelllang=en_us<cr>", { desc = "Toggle spellcheck" })
map("n", "\\l", "<cmd>setlocal list!<cr>", { desc = "Toggle invisible characters" })
map("n", "\\n", "<cmd>setlocal number!<cr>", { desc = "Toggle line numbers" })
map("n", "\\w", "<cmd>setlocal wrap!<cr>", { desc = "Toggle line wrapping" })

map("n", "\\c", function()
  vim.opt_local.colorcolumn = vim.wo.colorcolumn == "" and "80" or ""
end, { desc = "Toggle 80-column marker" })

-- Switch between two-space indentation and hard tabs.
map("n", "\\t", function()
  if vim.bo.expandtab then
    vim.bo.expandtab = false
    vim.bo.softtabstop = 0
  else
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
  end
  vim.bo.shiftwidth = 2
  vim.notify(vim.bo.expandtab and "Indenting with spaces" or "Indenting with tabs")
end, { desc = "Toggle tabs/spaces" })

map("n", "<leader>m", function()
  vim.o.mouse = vim.o.mouse == "" and "a" or ""
  vim.notify(vim.o.mouse == "" and "Mouse off" or "Mouse on")
end, { desc = "Toggle mouse" })
