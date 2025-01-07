return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "jinh0/eyeliner.nvim",
    },
    keys = {
      ";",
      ",",
      "t",
      "f",
      "T",
      "F",
    },
    config = function()
      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
      local nxo = { "n", "x", "o" }

      vim.keymap.set(nxo, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set(nxo, ",", ts_repeat_move.repeat_last_move_opposite)

      local function eyeliner_jump(key)
        local forward = vim.list_contains({ "t", "f" }, key)
        return function()
          require("eyeliner").highlight({ forward = forward })
          return ts_repeat_move["builtin_" .. key .. "_expr"]()
        end
      end

      vim.keymap.set(nxo, "f", eyeliner_jump("f"), { expr = true })
      vim.keymap.set(nxo, "F", eyeliner_jump("F"), { expr = true })
      vim.keymap.set(nxo, "t", eyeliner_jump("t"), { expr = true })
      vim.keymap.set(nxo, "T", eyeliner_jump("T"), { expr = true })
    end,
  },
  {
    "jinh0/eyeliner.nvim",
    opts = {
      highlight_on_key = true,
      dim = true,
      default_keymaps = false,
    },
    init = function()
      vim.api.nvim_set_hl(0, "EyelinerDimmed", { link = "Comment" })
      vim.api.nvim_set_hl(0, "EyelinerPrimary", { link = "SpecialChar" })
      vim.api.nvim_set_hl(0, "EyelinerSecondary", { link = "Type" })
      -- vim.api.nvim_set_hl(0, "EyelinerDimmed", { link = "Comment" })
      -- vim.api.nvim_set_hl(0, "EyelinerPrimary", { link = "IncSearch" })
      -- vim.api.nvim_set_hl(0, "EyelinerSecondary", { link = "Substitute" })
    end,
  },
}
