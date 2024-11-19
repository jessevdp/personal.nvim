return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    -- Set mapped sequence wait time
    -- Determines when which-key popup shows
    vim.opt.timeout = true
    vim.opt.timeoutlen = 900
  end,
  opts = {
    spec = {
      { "<leader>s", group = "[S]earch" },
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>w", group = "[W]orkspace" },
      { "<leader>m", group = "[M]ove (swap) textobjects" },
      { "<leader>p", group = "[P]eek Definition" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Buffer Keymaps",
    },
  },
}
