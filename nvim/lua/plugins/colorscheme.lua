-- base16 ships the same Tomorrow Night Eighties palette used by the vim config,
-- but with the treesitter and LSP highlight groups Neovim needs.
return {
  {
    "RRethy/base16-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      pcall(vim.cmd.colorscheme, "base16-tomorrow-night-eighties")

      -- Let the sign column blend into the background, as gitgutter did.
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    end,
  },
}
