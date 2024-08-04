return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "gruvbox", -- "catppuccin",
      section_separators = "",
      component_separators = { left = "|", right = "|" },
    },
  },
}

