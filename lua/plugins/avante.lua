return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make BUILD_FROM_SOURCE=true luajit", -- needs Rust installed -- build = "make",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    provider = "iogpt",
    auto_suggestions_provider = "iogpt",
    vendors = {
      ---@type AvanteProvider
      iogpt = {
        endpoint = "https://iogpt-api-management-service.azure-api.net/openai/api/proxy/openai/",
        model = "gpt-4o",
        api_key_name = "IOGPT_API_KEY",
        parse_curl_args = function(opts, code_opts)
          return require("avante.providers").openai.parse_curl_args(opts, code_opts)
        end,
        parse_response_data = function(data_stream, event_state, opts)
          require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        end,
      },
    },
    hints = { enabled = false },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    windows = {
      sidebar_header = {
        align = "left",
        rounded = false,
      },
    },
    highlights = {
      ---@type AvanteConflictHighlights
      diff = {
        current = "DiffDelete",
        incoming = "DiffAdd",
      },
    },
    mappings = {
      ask = "<leader>aa",
      edit = "<leader>ae",
      refresh = "<leader>ar",
      --- @class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<C-y>",
        insert = "<C-y>",
      },
      sidebar = {
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
      toggle = {
        debug = "<leader>ad",
        hint = "<leader>ah",
      },
    },
  },
}

