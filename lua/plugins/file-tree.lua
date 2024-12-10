return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "single",
      window = {
        position = "float",
        mappings = {
          ["\\"] = "close_window",
          ["<C-c>"] = "close_window",
        },
        popup = {
          border = {
            style = "single",
            text = {
              top = " File Tree ",
              top_align = "center",
            },
          },
        },
      },
      source_selector = {
        sources = {
          { source = "filesystem" },
        },
      },
    },
    keys = {
      { "\\", "<cmd>Neotree reveal<CR>", { desc = "File tree" } },
    },
  },
}
