return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VimEnter",
  keys = {
    { "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "[S]earch [F]iles" },
    { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "[S]earch by [G]rep" },
    { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "[S]earch current [W]ord" },
    { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "[S]earch [H]elp" },
    { "<leader>s.", "<cmd>Telescope oldfiles<CR>", desc = "[S]earch Recent Files ('.' for repeat)" },
    { "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "Search Existing Buffers" },
    { "<leader>sr", "<cmd>Telescope resume<CR>", desc = "[S]earch [R]esume" },
  },
  opts = {
    defaults = {
      prompt_prefix = "   ",
      selection_caret = " 󰁔 ",
      entry_prefix = "   ",
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        width = 0.77,
        height = 0.80,
      },
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      mappings = {
        n = { ["q"] = "close" },
      },
    },
  },
}
