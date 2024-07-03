return {
  "m4xshen/smartcolumn.nvim", -- rulers
  opts = {
    colorcolumn = { 81, 121 },
    disabled_filetypes = {
      "help",
      "text",
      "markdown",

      -- disable rulers for plugin specific buffers
      "lazy",
      "checkhealth",
      "alpha",
      "neo-tree",
    },
  },
}
