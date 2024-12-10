return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      overrides = {
        CursorLineNr = { bg = "" },
        SignColumn = { link = "Normal" },

        GruvboxRedSign = { bg = "" },
        GruvboxAquaSign = { bg = "" },
        GruvboxBlueSign = { bg = "" },
        GruvboxGreenSign = { bg = "" },
        GruvboxOrangeSign = { bg = "" },
        GruvboxPurpleSign = { bg = "" },
        GruvboxYellowSign = { bg = "" },

        NormalFloat = { link = "GruvboxFg1" },
        FloatTitle = { link = "FloatBorder" },

        ["@method.call"] = { link = "GruvboxAqua" },
        ["@function.call"] = { link = "GruvboxAqua" },


        -- Ruby specific overrides
        ["@lsp.typemod.method.declaration.ruby"] = { link = "rubyMethodName" },
        ["@lsp.type.method.ruby"] = { link = "@function.call" },
        ["@lsp.type.namespace.ruby"] = { link = "rubyClassName" },
      },
    },
    init = function()
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
