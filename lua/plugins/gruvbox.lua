return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = true,
  opts = {
    overrides = {
      CursorLineNr = { bg = "" },
      SignColumn = { link = "Normal" },
      MarkSignNumHL = { link = "Normal" }, -- see: marks.nvim
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
    vim.cmd.colorscheme "gruvbox"
  end
}
