return {
  -- Show pending keybinds
  "folke/which-key.nvim",
  event = "VimEnter",
  init = function()
    -- Set mapped sequence wait time
    -- Determines when which-key popup shows
    vim.opt.timeout = true
    vim.opt.timeoutlen = 900
  end,
  config = function()
    -- Document existing key chains
    require("which-key").register {
      ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
      ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
      ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
      ["<leader>gh"] = { name = "[G]it [H]unk", _ = "which_key_ignore" },
      ["<leader>h"] = { name = "[H]arpoon", _ = "which_key_ignore" },
      ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
      ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
      ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
    }
    -- visual mode
    require("which-key").register({
      ["<leader>g"] = { "[G]it" },
      ["<leader>gh"] = { "Git [H]unk" },
      ["<leader>s"] = { "[S]earch" },
    }, { mode = "v" })
  end,
}

