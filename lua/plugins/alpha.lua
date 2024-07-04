return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.startify")

    dashboard.section.header.val = {
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

    -- disable global MRU: I only want project specific files to show
    dashboard.section.mru.val = { { type = "padding", val = 0 } }

    dashboard.section.bottom_buttons.val = {
      dashboard.button("f", "Fuzzy-find file" , ":Telescope find_files<CR>"),
      dashboard.button("\\", "File tree" , ":Neotree reveal<CR>"),
      dashboard.button("g", "Get good" , ":VimBeGood<CR>"),
      dashboard.button("q", "Quit" , ":qa<CR>"),
    }

    dashboard.section.footer.val = {
      {
        type = "text",
        val = require("alpha.fortune"),
        opts = { hl = "Conceal" },
      },
    }

    alpha.setup(dashboard.opts)
  end,
}

