return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "VeryLazy" },
    opts = {
      current_line_blame = true,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, desc, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.desc = desc
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]h", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Go to next Git [H]unk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[h", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Go to previous Git [H]unk")

        map("n", "[H", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[H", bang = true })
          else
            gitsigns.nav_hunk("first")
          end
        end, "Go to first Git [H]unk")

        map("n", "]H", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]H", bang = true })
          else
            gitsigns.nav_hunk("last")
          end
        end, "Go to last Git [H]unk")

        -- Actions
        map("n", "<leader>ghs", gitsigns.stage_hunk, "[G]it [H]unk [S]tage")
        map("v", "<leader>ghs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "[G]it [H]unk [S]tage")
        map("n", "<leader>ghu", gitsigns.undo_stage_hunk, "[G]it [H]unk [U]ndo Stage")
        map("n", "<leader>ghr", gitsigns.reset_hunk, "[G]it [H]unk [R]eset")
        map("v", "<leader>ghr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "[G]it [H]unk [R]eset")
        map("n", "<leader>ghp", gitsigns.preview_hunk, "[G]it [H]unk [P]review")

        map("n", "<leader>ghR", gitsigns.reset_buffer, "[G]it [R]eset Buffer")
        map("n", "<leader>ghS", gitsigns.stage_buffer, "[G]it [S]tage Buffer")
        map("n", "<leader>ghU", gitsigns.reset_buffer_index, "[G]it [U]ndo Stage Buffer")

        map("n", "<leader>gd", function() gitsigns.diffthis("@") end, "[G]it [D]iff against HEAD")
        map("n", "<leader>gD", function() gitsigns.diffthis("main") end, "[G]it [D]iff against main")

        map("n", "<leader>gb", function()
          gitsigns.blame_line({ full = true })
        end, "[G]it [B]lame Line")
        map("n", "<leader>gB", gitsigns.blame, "[G]it [B]lame File")

        map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, "[G]it [T]oggle Current-line [B]lame")
        map("n", "<leader>gtw", gitsigns.toggle_word_diff, "[G]it [T]oggle [W]ord Diff")
        map("n", "<leader>gtd", gitsigns.toggle_deleted, "[G]it [T]oggle [D]eleted")

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk, "Git [H]unk")
        map({ "o", "x" }, "ah", gitsigns.select_hunk, "Git [H]unk")
      end,
    },
  },
}
