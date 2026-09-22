return {
  -- File tree, replacing nerdtree + nerdtree-tabs.
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>n", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
      { "<leader>N", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal file in tree" },
    },
    opts = {
      sync_root_with_cwd = true,
      update_focused_file = { enable = true },
      view = { width = 34 },
      renderer = {
        group_empty = true,
        icons = { show = { file = vim.g.have_nerd_font, folder = vim.g.have_nerd_font } },
      },
      filters = { custom = { "^.git$" } },
      -- Closing the last real buffer shouldn't leave an empty tree behind.
      actions = { open_file = { quit_on_open = false } },
    },
  },

  -- Undo history browser, replacing gundo.
  {
    "mbbill/undotree",
    keys = { { "\\u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undo tree" } },
  },

  -- Change surrounding quotes/brackets/tags: cs"' , ds( , ysiw"
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  { "mattn/emmet-vim", ft = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact" } },
}
