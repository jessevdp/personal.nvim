return {
  {
    "echasnovski/mini.bufremove",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      {
        "<leader>x",
        function()
          require("mini.bufremove").delete()
        end,
        desc = "Close current buffer",
      },
      {
        "<leader>X",
        function()
          local bufnrs = vim.api.nvim_list_bufs()
          for _, bufnr in ipairs(bufnrs) do
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            vim.notify("Deleting buffer: " .. bufname, vim.log.levels.INFO)
            require("mini.bufremove").delete(bufnr)

          end
        end,
        desc = "Close all buffers",
      },
    },
  },
}
