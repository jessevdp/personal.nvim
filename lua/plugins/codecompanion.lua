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
      -- prompts
      { "<leader>ae", "<cmd>CodeCompanion /explain<cr>", mode = { "v" }, desc = "AI [E]xplain" },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "aio_openai",
          roles = {
            llm = "Assistant",
            user = "Me",
          },
        },
        inline = {
          adapter = "aio_openai",
        },
      },
      display = {
        chat = {
          intro_message = "  What can I help with? (Press ? for options)",
          show_references = true,
          show_header_separator = false,
          show_settings = false,
          window = {
            width = 0.4,
            opts = {
              relativenumber = false,
            },
          },
        },
        diff = {
          provider = "mini_diff",
        },
      },
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = os.getenv("OPENAI_API_KEY"),
            },
          })
        end,
        aio_openai = function()
          return require("plugins.codecompanion.aio-openai-adapter").make()
        end,
      },
    },
    init = function()
      vim.cmd([[cab cc CodeCompanion]])
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
