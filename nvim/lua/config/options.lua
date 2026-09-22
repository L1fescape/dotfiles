-- Editor settings, ported from ~/.vimrc.

-- Leader has to be set before lazy.nvim loads plugins so their mappings see it.
vim.g.mapleader = " "

-- Flip to true after installing a Nerd Font (https://nerdfonts.com) to get
-- file-type glyphs in the statusline, file tree and diagnostics.
vim.g.have_nerd_font = false

local opt = vim.opt

opt.autoread = true
opt.shortmess:append("atcI")
opt.wildmode = { "longest:list", "full" }
opt.ttimeoutlen = 0
opt.updatetime = 250

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true
opt.number = true
opt.signcolumn = "yes"
opt.scrolloff = 4
opt.wrap = true
opt.showcmd = true
opt.showmode = false -- lualine already shows the mode
opt.laststatus = 3 -- one statusline for the whole window, not per split
opt.list = true
opt.listchars = { tab = "▸ ", eol = "¬", trail = "•", nbsp = "␣" }
opt.guifont = "Ubuntu Mono Bold:h10"

-- Indentation: two spaces, toggle to hard tabs with \t
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- Splits open below and to the right
opt.splitbelow = true
opt.splitright = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Folds start open. The treesitter plugin upgrades foldexpr per filetype.
opt.foldenable = true
opt.foldmethod = "indent"
opt.foldlevelstart = 99
opt.foldnestmax = 10

-- No swap or backup files, but keep undo history across sessions so undotree
-- has something to show.
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true

opt.mouse = "a"
opt.fileformats = { "unix", "dos", "mac" }
opt.completeopt = { "menu", "menuone", "noselect" }
