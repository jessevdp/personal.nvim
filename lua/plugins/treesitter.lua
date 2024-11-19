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
      },
      indent = {
        enable = true,
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
            ["<leader>ma"] = { query = "@parameter.inner", desc = "[M]ove (swap) parameter/[A]rgument forwards" },
            ["<leader>mf"] = { query = "@function.outer", desc = "[M]ove (swap) [F]unction forwards" },
            ["<leader>mm"] = { query = "@function.outer", desc = "[M]ove (swap) [M]ethod forwards" },
          },
          swap_previous = {
            ["<leader>mA"] = { query = "@parameter.inner", desc = "[M]ove (swap) parameter/[A]rgument backwards" },
            ["<leader>mF"] = { query = "@function.outer", desc = "[M]ove (swap) [F]unction backwards" },
            ["<leader>mM"] = { query = "@function.outer", desc = "[M]ove (swap) [M]ethod backwards" },
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
}
