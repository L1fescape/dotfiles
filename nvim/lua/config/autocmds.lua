local function group(name)
  return vim.api.nvim_create_augroup("dotfiles_" .. name, { clear = true })
end

-- Briefly highlight text after yanking it.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Reopen files where you left off.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group("last_position"),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- <CR> clears search highlighting everywhere except lists, where it needs to
-- keep jumping to the entry under the cursor.
vim.api.nvim_create_autocmd("FileType", {
  group = group("cr_in_lists"),
  pattern = { "qf", "help", "lspinfo", "checkhealth", "man" },
  callback = function(args)
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = args.buf })
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, desc = "Close" })
  end,
})

-- Filetype tweaks carried over from the vim config.
vim.filetype.add({
  extension = {
    handlebars = "html",
    hbs = "html",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  group = group("scss_keywords"),
  pattern = { "scss", "css", "less" },
  callback = function()
    vim.opt_local.iskeyword:append("-")
  end,
})

-- Prose: soft wrap and spellcheck on by default.
vim.api.nvim_create_autocmd("FileType", {
  group = group("prose"),
  pattern = { "markdown", "gitcommit", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})
