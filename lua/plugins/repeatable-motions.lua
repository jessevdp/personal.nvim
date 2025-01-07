return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
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

      vim.keymap.set(nxo, "f", ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set(nxo, "F", ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set(nxo, "t", ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set(nxo, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
  },
}
