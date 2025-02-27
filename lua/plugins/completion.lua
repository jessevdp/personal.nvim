---@diagnostic disable: missing-fields
return {
  {
    "saghen/blink.cmp",
    version = "v0.*",
    event = { "InsertEnter", "CmdlineEnter" },
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
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          ["codecompanion"] = { "codecompanion", "lsp", "buffer" },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      completion = {
        ghost_text = { enabled = true },
        menu = {
          auto_show = function()
            if vim.bo.filetype == "codecompanion" then
              return true
            else
              return false
            end
          end,
          draw = {
            treesitter = { "lsp", "buffer", "snippets" },
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
            },
          },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 700,
          update_delay_ms = 50,
          window = {
            border = "single",
          },
        },
      },
      signature = { enabled = false },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "cmdline",
        },
        completion = {
          ghost_text = { enabled = true },
        },
      },
    },
  },
}
