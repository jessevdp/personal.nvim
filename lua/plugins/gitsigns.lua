return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]h", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Go to next Git [H]unk" })

      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[h", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Go to previous Git [H]unk" })

      map("n", "[H", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[H", bang = true })
        else
          gitsigns.nav_hunk("first")
        end
      end, { desc = "Go to first Git [H]unk" })

      map("n", "]H", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]H", bang = true })
        else
          gitsigns.nav_hunk("last")
        end
      end, { desc = "Go to last Git [H]unk" })

      -- Actions
      map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "[G]it [H]unk [S]tage" })
      map("v", "<leader>ghs", function()
        gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")}
      end, { desc = "[G]it  [H]unk [S]tage" })
      map("n", "<leader>ghu", gitsigns.undo_stage_hunk, { desc = "[G]it [H]unk [U]ndo Stage" })
      map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "[G]it [H]unk [R]eset" })
      map("v", "<leader>ghr", function()
        gitsigns.reset_hunk {vim.fn.line("."), vim.fn.line("v")}
      end, { desc = "[G]it [H]unk [R]eset" })
      map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "[G]it [H]unk [P]review" })

      map("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "[G]it [R]eset Buffer" })
      map("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "[G]it [S]tage Buffer" })

      map("n", "<leader>gb", function() gitsigns.blame_line{full=true} end, { desc = "[G]it [B]lame Line" })
      map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "[G]it [T]oggle Current-line [B]lame" })

      map("n", "<leader>gtd", gitsigns.toggle_deleted, { desc = "[G]it [T]oggle [D]eleted" })

      map("n", "<leader>gd", gitsigns.diffthis, { desc = "[G]it [D]iff" })
      -- map("n", "<leader>ghD", function() gitsigns.diffthis("~") end, { desc = "[G]it Hunk TODO" })

      -- Text object
      map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git [H]unk" })
    end
  },
}
