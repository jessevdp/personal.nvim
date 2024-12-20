return {
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        keyword = "bg",
        pattern = {
          [[.*<(KEYWORDS)\s*:]],
          [[.*<(KEYWORDS)\s*]],
        },
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon
      },
    },
  },
}
