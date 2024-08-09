return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window
    },
    cmd = "Neotree",
    keys = {
      { "\\", "<cmd>Neotree reveal<CR>", { desc = "NeoTree reveal" } },
    },
    opts = {
      window = {
        position = "right",
        mappings = {
          ["\\"] = "close_window",
        },
      },
    },
  },
  {
    -- allows picking a window to open the file into using "w" in neo-tree
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    opts = {
      hint = "floating-big-letter",
    },
  }
}

