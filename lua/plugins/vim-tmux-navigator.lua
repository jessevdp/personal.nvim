return {
  "christoomey/vim-tmux-navigator",
  keys = {
    { "<M-h>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<M-j>", "<cmd>TmuxNavigateDown<cr>" },
    { "<M-k>", "<cmd>TmuxNavigateUp<cr>" },
    { "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
    { "<M-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
  },
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end
}

