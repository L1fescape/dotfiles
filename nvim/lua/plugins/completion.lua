return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      -- Tab completes and cycles, matching the InsertTabWrapper binding the
      -- vim config uses. <C-e> dismisses, <CR> inserts a newline as usual.
      keymap = { preset = "super-tab" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 250 },
        menu = {
          draw = {
            columns = vim.g.have_nerd_font
                and { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } }
              or { { "label", "label_description", gap = 1 }, { "kind" } },
          },
        },
      },
      signature = { enabled = true },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
}
