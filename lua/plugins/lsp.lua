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
          map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          -- map("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
          map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          -- map("n", "gr", vim.lsp.buf.references, "[G]oto [R]eferences")

          map("n", "<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          map({ "n", "x" }, "<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")

          map("n", "<leader>ssd", require("telescope.builtin").lsp_document_symbols, "[S]earch [D]ocument [S]ymbols")
          map(
            "n",
            "<leader>ssw",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            "[S]earch [W]orkspace [S]ymbols"
          )

          vim.lsp.inlay_hint.enable(true)
        end,
      })

      local lspconfig = require("lspconfig").util.default_config
      local completion_capabilities = require("blink.cmp").get_lsp_capabilities()
      lspconfig.capabilities = vim.tbl_deep_extend("force", lspconfig.capabilities, completion_capabilities)

      if vim.fn.executable("lua-language-server") == 1 then
        require("lspconfig").lua_ls.setup({
          settings = {
            Lua = {
              format = { enable = false },
            },
          },
        })
      end

      if vim.fn.executable("ruby-lsp") == 1 then
        require("lspconfig").ruby_lsp.setup({
          cmd = { "direnv", "exec", ".", "ruby-lsp" },
        })
      end

      if vim.fn.executable("typescript-language-server") == 1 then
        require("lspconfig").ts_ls.setup({})
      end

      if vim.fn.executable("vscode-eslint-language-server") == 1 then
        require("lspconfig").eslint.setup({})
      end

      if vim.fn.executable("nixd") == 1 and vim.fn.executable("alejandra") == 1 then
        require("lspconfig").nixd.setup({
          cmd = { "nixd" },
          settings = {
            nixd = {
              nixpkgs = {
                expr = 'import (builtins.getFlake "/Users/jessevanderpluijm/.config/nix-system/config").inputs.nixpkgs { }',
              },
              formatting = {
                command = { "alejandra" },
              },
              options = {
                nix_darwin = {
                  expr = '(builtins.getFlake "/Users/jessevanderpluijm/.config/nix-system/config").darwinConfigurations."LJQPCW4D95".options',
                },
                home_manager = {
                  expr = '(builtins.getFlake "/Users/jessevanderpluijm/.config/nix-system/config").editorHomeManagerConfiguration.options',
                },
              },
            },
          },
        })
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.hover.dictionary,
          null_ls.builtins.hover.printenv,

          null_ls.builtins.formatting.stylua,

          -- Nix
          null_ls.builtins.diagnostics.statix,
          null_ls.builtins.diagnostics.deadnix,
        },
      })
    end,
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
