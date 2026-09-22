return {
  -- Statusline, replacing vim-airline.
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "auto",
          globalstatus = true,
          icons_enabled = vim.g.have_nerd_font,
          section_separators = vim.g.have_nerd_font and { left = "", right = "" } or "",
          component_separators = vim.g.have_nerd_font and { left = "", right = "" } or "|",
        },
        sections = {
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "filetype" },
        },
      }
    end,
  },

  -- Popup listing what follows <leader> or \ while you hesitate.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { "<leader>c", group = "code" },
        { "<leader>g", group = "git" },
        { "\\", group = "toggles" },
      },
    },
  },

  -- Only pulled in when a Nerd Font is available; other plugins ask for it.
  { "nvim-tree/nvim-web-devicons", lazy = true, enabled = vim.g.have_nerd_font },
}
