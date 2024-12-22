---@diagnostic disable: missing-fields
return {
  {
    "saghen/blink.cmp",
    version = "v0.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        menu = {
          auto_show = false,
        },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        completion = {
          enabled_providers = function()
            if vim.bo.filetype == "codecompanion" then
              return { "codecompanion" }
            else
              return { "lsp", "path", "snippets", "buffer" }
            end
          end,
        },
        providers = {
          codecompanion = {
            name = "CodeCompanion",
            module = "codecompanion.providers.completion.blink",
            enabled = true,
          },
        },
      },
    },
  },
}
