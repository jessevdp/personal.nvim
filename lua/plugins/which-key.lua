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
    require("which-key").add({
        { "<leader>c",   group = "[C]ode" },
        { "<leader>c_",  hidden = true },
        { "<leader>d",   group = "[D]ocument" },
        { "<leader>d_",  hidden = true },
        { "<leader>g",   group = "[G]it" },
        { "<leader>g_",  hidden = true },
        { "<leader>gh",  group = "[G]it [H]unk" },
        { "<leader>gh_", hidden = true },
        { "<leader>gt",  group = "[G]it [T]oggle" },
        { "<leader>gt_", hidden = true },
        { "<leader>h",   group = "[H]arpoon" },
        { "<leader>h_",  hidden = true },
        { "<leader>r",   group = "[R]ename" },
        { "<leader>r_",  hidden = true },
        { "<leader>s",   group = "[S]earch" },
        { "<leader>s_",  hidden = true },
        { "<leader>w",   group = "[W]orkspace" },
        { "<leader>w_",  hidden = true },
        -- { "<leader>t", group = "[T]oggle" },
        -- { "<leader>t_", hidden = true },
      },
      {
        mode = "v",
        ["<leader>g"] = { "[G]it" },
        ["<leader>gh"] = { "Git [H]unk" },
        ["<leader>s"] = { "[G]it" },
      })
  end,
}
