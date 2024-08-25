return {
  "m4xshen/smartcolumn.nvim", -- rulers
  opts = {
    colorcolumn = { 80, 120 },
    disabled_filetypes = {
      "help",
      "text",
      "markdown",

      -- disable rulers for plugin specific windows/buffers
      "lazy",
      "checkhealth",
      "alpha",
      "neo-tree",
      "mason",
      "lspinfo",
    },
  },
}

