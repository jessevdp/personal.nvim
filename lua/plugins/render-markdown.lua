return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = {
      "markdown",
      "codecompanion",
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- Workaround for highlight issue related to breakindent.
      -- See: https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/149
      win_options = { breakindent = { default = true, rendered = false } },
    },
  },
}
