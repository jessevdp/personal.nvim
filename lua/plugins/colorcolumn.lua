return {
  {
    "m4xshen/smartcolumn.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      colorcolumn = { 80, 120 },
      scope = "window",
      disabled_filetypes = {
        "help",
        "text",
        "markdown",

        -- disable rulers for plugin specific windows/buffers
        "lazy",
        "checkhealth",
        "mason",
        "lspinfo",
      },
    },
  },
}
