return {
  "fmbarina/multicolumn.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    base_set = {
      full_column = true,
      always_on = false,
    },
  },
}

