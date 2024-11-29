return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "ray-x/cmp-treesitter",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      completion = {
        autocomplete = false,
      },
      mapping = {
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = function()
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end,
        ["<C-l>"] = cmp.mapping(function(fallback)
          if vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "treesitter" },
        { name = "buffer" },
      }),
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            buffer = "[Buf]",
            treesitter = "[TS]",
          })[entry.source.name]
          return vim_item
        end,
      },
    })
  end,
}
