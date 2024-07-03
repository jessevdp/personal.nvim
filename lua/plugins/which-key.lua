return {
  -- Show pending keybinds
  "folke/which-key.nvim",
  event = 'VimEnter',
  init = function()
    -- Set mapped sequence wait time
    -- Determines when which-key popup shows
    vim.opt.timeout = true
    vim.opt.timeoutlen = 900
  end,
  config = function()
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').register {
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    }
  end,
}

