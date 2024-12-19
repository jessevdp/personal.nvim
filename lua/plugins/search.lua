return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  event = "VimEnter",
  keys = {
    { "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "[S]earch [F]iles" },
    { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "[S]earch by [G]rep" },
    { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "[S]earch current [W]ord" },
    { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "[S]earch [H]elp" },
    { "<leader>sr", "<cmd>Telescope oldfiles<CR>", desc = "[S]earch [R]ecent Files" },
    { "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "Search Existing Buffers" },
    { "<leader>s.", "<cmd>Telescope resume<CR>", desc = "[S]earch Resume" },
    {
      "<leader>s/",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          previewer = false,
          borderchars = {
            prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
        }))
      end,
      desc = "[S]earch Fuzzily in current buffer",
    },
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
        i = {
          ["<C-q>"] = "send_to_qflist",
          ["<C-Q>"] = "add_to_qflist",
          ["<M-q>"] = "smart_send_to_qflist",
          ["<M-Q>"] = "smart_add_to_qflist",
        },
        n = {
          ["q"] = "close",

          ["<C-q>"] = "send_to_qflist",
          ["<C-Q>"] = "add_to_qflist",
          ["<M-q>"] = "smart_send_to_qflist",
          ["<M-Q>"] = "smart_add_to_qflist",
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          borderchars = {
            prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
        }),
      },
    },
  },
  init = function()
    require("telescope").load_extension("ui-select")
  end,
}
