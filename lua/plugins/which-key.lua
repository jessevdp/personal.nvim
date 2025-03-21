return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    -- Set mapped sequence wait time
    -- Determines when which-key popup shows
    vim.opt.timeout = true
    vim.opt.timeoutlen = 900
  end,
  --- @class wk.Opts
  opts = {
    preset = "helix",
    win = {
      border = "single",
    },
    spec = {
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>cm", group = "[M]ove (swap) textobjects" },
      { "<leader>g", group = "[G]it" },
      { "<leader>gh", group = "[G]it [H]unk" },
      { "<leader>gt", group = "[G]it [T]oggle" },
      { "<leader>l", group = "[L]ist" },
      { "<leader>p", group = "[P]eek Definition" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>ss", group = "[S]earch LSP [S]ymbols" },
      { "<leader>ss", group = "[S]earch LSP [S]ymbols" },
      { "gs", group = "[S]urround" },
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
