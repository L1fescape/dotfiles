-- Telescope covers what ctrlp (file finding) and ag.vim (project search) used
-- to do, so the old <leader>o and <leader>a mappings keep working.
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      { "<leader>o", "<cmd>Telescope find_files<cr>", desc = "Open file" },
      { "<leader>a", "<cmd>Telescope live_grep<cr>", desc = "Search in project" },
      { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Search in project" },
      { "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "Search word under cursor" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Open buffers" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
      { "<leader>?", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<leader>gf", "<cmd>Telescope git_status<cr>", desc = "Changed files" },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix = "> ",
          selection_caret = "> ",
          path_display = { "truncate" },
          file_ignore_patterns = { "^%.git/", "/%.git/", "node_modules/" },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          -- ag.vim searched hidden files too; keep that behaviour.
          find_files = { hidden = true },
        },
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_dropdown() },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
    end,
  },
}
