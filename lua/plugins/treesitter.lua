return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ensure_installed = {
        "bash",
        "diff",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "query",
        "regex",
        "ruby",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = {
        enable = true,
        disable = { "ruby" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-CR>",
          node_incremental = "<CR>",
          scope_incremental = false,
          node_decremental = "<BS>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ac"] = { query = "@class.outer", desc = "class" },
            ["ic"] = { query = "@class.inner", desc = "inner class" },
            ["af"] = { query = "@function.outer", desc = "function" },
            ["if"] = { query = "@function.inner", desc = "inner function" },
            ["am"] = { query = "@function.outer", desc = "method" },
            ["im"] = { query = "@function.inner", desc = "inner method" },
            ["ao"] = { query = "@block.outer", desc = "block" },
            ["io"] = { query = "@block.inner", desc = "inner block" },
            -- ["al"] = { query = "@loop.outer", desc = "loop" },
            -- ["il"] = { query = "@loop.inner", desc = "inner loop" },
            ["aa"] = { query = "@parameter.outer", desc = "parameter/argument" }, -- parameter -> argument
            ["ia"] = { query = "@parameter.inner", desc = "inner parameter/argument" },
            ["ar"] = { query = "@regex.outer", desc = "regex" },
            ["ir"] = { query = "@regex.inner", desc = "inner regex" },
            ["ak"] = { query = "@comment.outer", desc = "comment" },
            ["ik"] = { query = "@comment.outer", desc = "around comment" }, -- no inner for comment
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>cma"] = { query = "@parameter.inner", desc = "Swap parameter/[A]rgument forwards" },
            ["<leader>cmf"] = { query = "@function.outer", desc = "Swap [F]unction forwards" },
            ["<leader>cmm"] = { query = "@function.outer", desc = "Swap [M]ethod forwards" },
          },
          swap_previous = {
            ["<leader>cmA"] = { query = "@parameter.inner", desc = "Swap parameter/[A]rgument backwards" },
            ["<leader>cmF"] = { query = "@function.outer", desc = "Swap [F]unction backwards" },
            ["<leader>cmM"] = { query = "@function.outer", desc = "Swap [M]ethod backwards" },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]c"] = { query = "@class.outer", desc = "Go to next [C]lass start" },
            ["]]"] = { query = "@class.outer", desc = "Go to next class start" },
            ["]f"] = { query = "@function.outer", desc = "Go to next [F]unction start" },
            ["]m"] = { query = "@function.outer", desc = "Go to next [M]ethod start" },
            ["]a"] = { query = "@parameter.inner", desc = "Go to next parameter/[A]rgument start" },
            ["]k"] = { query = "@comment.outer", desc = "Go to next [C]omment start" },
          },
          goto_next_end = {
            ["]C"] = { query = "@class.outer", desc = "Go to next [C]lass end" },
            ["]["] = { query = "@class.outer", desc = "Go to next class end" },
            ["]F"] = { query = "@function.outer", desc = "Go to next [F]unction end" },
            ["]M"] = { query = "@function.outer", desc = "Go to next [M]ethod end" },
            ["]A"] = { query = "@parameter.inner", desc = "Go to next parameter/[A]rgument end" },
            ["]K"] = { query = "@comment.outer", desc = "Go to next [C]omment end" },
          },
          goto_previous_start = {
            ["[c"] = { query = "@class.outer", desc = "Go to previous [C]lass start" },
            ["[["] = { query = "@class.outer", desc = "Go to previous class start" },
            ["[f"] = { query = "@function.outer", desc = "Go to previous [F]unction start" },
            ["[m"] = { query = "@function.outer", desc = "Go to previous [M]ethod start" },
            ["[a"] = { query = "@parameter.inner", desc = "Go to previous parameter/[A]rgument start" },
            ["[k"] = { query = "@comment.outer", desc = "Go to previous [C]omment start" },
          },
          goto_previous_end = {
            ["[C"] = { query = "@class.outer", desc = "Go to previous [C]lass end" },
            ["[]"] = { query = "@class.outer", desc = "Go to previous class end" },
            ["[F"] = { query = "@function.outer", desc = "Go to previous [F]unction end" },
            ["[M"] = { query = "@function.outer", desc = "Go to previous [M]ethod end" },
            ["[A"] = { query = "@parameter.inner", desc = "Go to previous parameter/[A]rgument end" },
            ["[K"] = { query = "@comment.outer", desc = "Go to previous [C]omment end" },
          },
        },
        lsp_interop = {
          enable = true,
          border = "none",
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>pf"] = { query = "@function.outer", desc = "[P]eek [F]unction Definition" },
            ["<leader>pF"] = { query = "@class.outer", desc = "[P]eek [F]unction host Class Definition" },
            ["<leader>pm"] = { query = "@function.outer", desc = "[P]eek [M]ethod Definition" },
            ["<leader>pM"] = { query = "@class.outer", desc = "[P]eek [M]ethod host Class Definition" },
            ["<leader>pc"] = { query = "@class.outer", desc = "[P]eek [C]lass Definition" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
  },
  {
    "Wansmer/treesj",
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    keys = {
      {
        "<leader>cs",
        function()
          require("treesj").split()
        end,
        desc = "[S]plit Treesitter node",
      },
      {
        "<leader>cS",
        function()
          require("treesj").split({ split = { recursive = true } })
        end,
        desc = "[S]plit Treesitter node recursively",
      },
      {
        "<leader>cj",
        function()
          require("treesj").join()
        end,
        desc = "[J]oin Treesitter node",
      },
      {
        "<leader>cJ",
        function()
          require("treesj").join({ join = { recursive = true } })
        end,
        desc = "[J]oin Treesitter node recursively",
      },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
}
