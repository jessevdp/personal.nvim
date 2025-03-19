local group = vim.api.nvim_create_augroup("highlight-current-word", { clear = true })
local highlight = "CurrentWordHighlight"

local link = vim.api.nvim_get_hl(0, { name = "GruvboxBg2" })
vim.api.nvim_set_hl(0, highlight, { background = link.fg })

vim.api.nvim_create_autocmd("CursorHold", {
  desc = "Highlight current word",
  group = group,
  callback = function()
    if vim.v.hlsearch ~= 0 then
      return
    end

    local word = vim.fn.expand("<cword>")
    vim.fn.matchadd(highlight, "\\<" .. word .. "\\>")
  end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
  desc = "Clear current word highlight",
  group = group,
  callback = function()
    vim.fn.clearmatches()
  end,
})
