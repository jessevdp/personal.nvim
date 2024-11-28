return {
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        keyword = "bg",
      },
    },
  },
}
