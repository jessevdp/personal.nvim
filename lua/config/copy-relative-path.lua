vim.api.nvim_create_user_command("CopyRelativePath", function()
  vim.fn.chdir(".")

  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
