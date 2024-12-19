return {
  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local theme = require("alpha.themes.startify")

      theme.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }

      -- disable global MRU
      theme.section.mru.val = { { type = "padding", val = 0 } }

      theme.section.bottom_buttons.val = {
        theme.button("f", "Search for file", "<cmd>Telescope find_files<CR>"),
        theme.button("/", "Search by grep", "<cmd>Telescope live_grep<CR>"),
        theme.button("q", "Quit", "<cmd>qa<CR>"),
      }

      theme.section.footer.val = {
        {
          type = "text",
          val = require("alpha.fortune"),
          opts = { hl = "Conceal" },
        },
      }

      alpha.setup(theme.config)
    end,
  },
}
