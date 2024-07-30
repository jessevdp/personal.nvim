return {
  "nvim-treesitter/nvim-treesitter-context",
  opts = {
    enable = false,
  },
  init = function()
    vim.keymap.set("n", "[c", function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end, { desc = "Go up to [C]ontext", silent = true })
  end
}

