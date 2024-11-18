return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
          map("n", "gs", vim.lsp.buf.signature_help, "[G]oto [S]ignature Help")

          map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          -- map("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

          map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          -- map("n", "gr", vim.lsp.buf.references, "[G]oto [R]eferences")

          map("n", "<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          map({ "n", "x" }, "<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")

          map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
          map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      ensure_installed = { "lua_ls" },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,
      }
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      "Bilal2453/luvit-meta",
    },
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
}
