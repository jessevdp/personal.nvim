vim.api.nvim_create_user_command("ExploreAndFocus", function()
  local current_file = vim.fn.expand("%:t")
  vim.cmd("Explore")
  vim.fn.search("\\<" .. vim.fn.escape(current_file, "\\") .. "\\>")
end, {})
