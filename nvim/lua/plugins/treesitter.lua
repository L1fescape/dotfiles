-- Treesitter replaces the pile of per-language syntax plugins the vim config
-- carried (vim-json, vim-javascript, css.vim, scss-syntax, html5, typescript).

local parsers = {
  "bash",
  "c",
  "clojure",
  "css",
  "diff",
  "dockerfile",
  "git_config",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "ruby",
  "scss",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- nvim-treesitter does not support lazy loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})

      -- No-op for parsers that are already present.
      local installing = require("nvim-treesitter").install(parsers)

      -- Headless means install.sh is doing the initial setup. Block there so
      -- parsers finish compiling instead of being killed half-written.
      if installing and #vim.api.nvim_list_uis() == 0 then
        installing:wait(600000)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("dotfiles_treesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang then
            return
          end
          local ok, added = pcall(vim.treesitter.language.add, lang)
          if not ok or added == false then
            return
          end

          pcall(vim.treesitter.start, args.buf, lang)
          vim.wo[0][0].foldmethod = "expr"
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end,
      })
    end,
  },

  -- Colour-matched brackets, replacing rainbow_parentheses.
  { "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPost", "BufNewFile" } },
}
