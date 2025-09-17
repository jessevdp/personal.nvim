return {
  {
    "dimtion/guttermarks.nvim",
    event = "VeryLazy",
    opts = {
      special_mark = {
        enabled = true,
        marks = {
          "'",
          "^",
          ".",
          "[",
          "]",
          "<",
          ">",
          '"',
          "`",
          '"',
        },
      },
    },
    init = function()
      vim.api.nvim_set_hl(0, "GutterMarksLocal", { link = "GruvboxBg4" })
      vim.api.nvim_set_hl(0, "GutterMarksGlobal", { link = "GruvboxBg4" })
      vim.api.nvim_set_hl(0, "GutterMarksSpecial", { link = "GruvboxBg2" })
    end,
  },
}
