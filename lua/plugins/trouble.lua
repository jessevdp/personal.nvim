return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      auto_preview = false,
    },
    keys = {
      {
        "<leader>ld",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "[D]iagnostics",
      },
      {
        "<leader>lD",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer [D]iagnostics",
      },
      {
        "<leader>lq",
        "<cmd>Trouble qflist toggle focus=true<cr>",
        desc = "[Q]uickfix",
      },
      {
        "<leader>ll",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "[L]ocation",
      },
    },
  },
}
