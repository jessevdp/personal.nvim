return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      modes = {
        search = { enabled = false },
        char = { enabled = false },
        treesitter_search = {
          remote_op = { restore = true, motion = true },
        },
      },
      prompt = {
        prefix = { { " 󰉁 ", "FlashPromptIcon" } },
      },
    },
    init = function()
      vim.api.nvim_set_hl(0, "FlashLabel", { link = "Special" })
    end,
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          ---@diagnostic disable-next-line: missing-fields
          require("flash").treesitter({ highlight = { backdrop = true } })
        end,
        desc = "Flash Treesitter Selection",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Remote Flash Treesitter Selection",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
}
