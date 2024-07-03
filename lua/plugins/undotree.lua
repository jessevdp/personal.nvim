return {
  "jiaoshijie/undotree",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    float_diff = false,
  },
  init = function()
    vim.keymap.set("n", "<leader>u", require("undotree").toggle, { desc = "Toggle [U]ndotree" })
  end
}

