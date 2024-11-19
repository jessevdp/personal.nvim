return {
  {
    "andrewferrier/wrapping.nvim",
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    opts = {
      create_commands = true,
      create_keymaps = false,
    },
  },
}
