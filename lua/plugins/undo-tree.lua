return {
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      float_diff = false,
    },
    keys = {
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", { desc = "[U]ndo-tree" } },
    },
  },
}
