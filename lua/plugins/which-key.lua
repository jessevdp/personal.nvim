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
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>m", group = "[M]ove (swap) textobjects" },
      { "<leader>p", group = "[P]eek Definition" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>ss", group = "[S]earch LSP [S]ymbols" },
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
