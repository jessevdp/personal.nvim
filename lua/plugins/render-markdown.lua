return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = {
        "markdown",
        "codecompanion",
      },
      -- Workaround for highlight issue related to breakindent.
      -- See: https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/149
      win_options = { breakindent = { default = true, rendered = false } },
    },
  },
}
