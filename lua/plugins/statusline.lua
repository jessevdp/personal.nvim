return {
  {
    "nvim-lualine/lualine.nvim",
    event = { "VimEnter" },
    opts = {
      options = {
        section_separators = "",
        component_separators = { left = "|", right = "|" },
        disabled_filetypes = {
          "alpha",
          "trouble",
        }
      },
      extensions = {
        "quickfix",
        "trouble",
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(s)
              local mode_map = {
                ["NORMAL"] = "N",
                ["O-PENDING"] = "N?",
                ["INSERT"] = "I",
                ["VISUAL"] = "V",
                ["V-BLOCK"] = "VB",
                ["V-LINE"] = "VL",
                ["V-REPLACE"] = "VR",
                ["REPLACE"] = "R",
                ["COMMAND"] = "!",
                ["SHELL"] = "SH",
                ["TERMINAL"] = "T",
                ["EX"] = "X",
                ["S-BLOCK"] = "SB",
                ["S-LINE"] = "SL",
                ["SELECT"] = "S",
                ["CONFIRM"] = "Y?",
                ["MORE"] = "M",
              }
              return mode_map[s] or s
            end,
          },
        },
        lualine_b = {
          "diff",
          "diagnostics",
        },
        lualine_c = {
          "filename",
        },
        lualine_x = {
          "filetype",
        },
        lualine_y = {
          "progress",
        },
        lualine_z = {
          "location",
        },
      },
      extensions = {
        "quickfix",
      },
    },
  },
}
