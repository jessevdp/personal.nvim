return {
  {
    "olimorris/codecompanion.nvim",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Toggle [C]hat" },
      { "<leader>an", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "AI [N]ew Chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI [A]ction" },
      { "ga", "<cmd>CodeCompanionChat Add<CR>", mode = { "v" }, desc = "AI [A]dd to Chat" },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "aio_openai",
        },
        inline = {
          adapter = "aio_openai",
        },
      },
      display = {
        diff = {
          provider = "mini_diff",
        },
      },
      adapters = {
        aio_openai = function()
          return require("plugins.codecompanion.aio-openai-adapter").make()
        end,
      },
    },
    init = function()
      require("plugins.codecompanion.fidget-spinner"):init()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "codecompanion" } },
      },
      {
        "echasnovski/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            source = diff.gen_source.none(),
          })
        end,
      },
    },
  },
}
